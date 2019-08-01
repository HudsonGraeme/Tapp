//
//  StartV2.swift
//  Tapp
//
//  Created by D. graham on 2019-07-08.
//  Copyright © 2019 Carspotter Daily. All rights reserved.
//

/*
Should be a splitview controller with Powerwall and Vehicle view depending on
*/


/*
 On Load:
 1. Contact Carspotter and compare versions (42-59)
 2A. Check if there is a saved access token
 I. Load data from .Tapp file and create a new one
 II. Check if User has multiple vehicles || One vehicle and powerwall(s) || Just Powerwalls || Just Vehicles, send appropriate notification to new vc
 III. Send the user into the vehicle selection screen and use previous data
 IV. Begin background qos new data load in new vc
 2B. Check if there is a saved access token
 I. Load the view
 3.
 
 
 
 */
var headers = [
    "Authorization" : "Bearer"
]

import Foundation
import Cocoa
import Alamofire
import KeychainAccess
import SSZipArchive
import SwiftWebSocket

class Login: NSViewController {
    
    let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        
        self.view.layer!.cornerRadius = 10.0
        // 1. Contact Carspotter and compare versions (42-59)
        Alamofire.request(URL(string: "http://api.carspotter.ca/index.php/Applications?transform=1")!).responseVersion { (response) in
            group.enter()
            let versionReadable = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! NSString)
            let version = NumberFormatter().number(from: versionReadable.replacingCharacters(in: NSRange(location: 3, length: 1), with: ""))!.doubleValue
            
            if let v = response.result.value {
                if (v.applications[0].latestVersion > version){
                    self.view.window!.setIsVisible(false)
                    let response = Alert("New Software Available!", "A new version of Tapp is available (\(v.applications[0].latestVersion)). Would you like to update from your current version (\(versionReadable))?", .informational, 2, ["Update", "Cancel"])
                    
                    if (response == 1001) {
                        self.view.window!.setIsVisible(true)
                        self.view.setFrameSize(NSSize(width: 450.0, height: 200.0))
                        self.view.window!.setFrame(NSRect(x: self.view.window!.frame.origin.x, y: self.view.window!.frame.origin.y, width: 450.0, height: 200.0), display: true, animate: true)
                        let progressIndicator = NSProgressIndicator(frame: NSRect(x: 20.0,y: 56.0,width: 414,height: 15))
                        progressIndicator.minValue = 0.0
                        progressIndicator.maxValue = 1.00
                        progressIndicator.isIndeterminate = false
                        progressIndicator.style = .bar
                        progressIndicator.controlTint = .blueControlTint
                        progressIndicator.isHidden = false
                        
                      progressIndicator.doubleValue = 0.0
                        print(self.Background.subviews)
                        for (subview) in (self.Background.subviews) {
                            if(subview != self.TappText) {
                            subview.isHidden = true
                            }
                        }
                       
                        self.TappText.stringValue = "Updating..."
                        self.view.window?.contentView?.addSubview(progressIndicator)
                        
                        func removeFile(atPath path: String) {
                        if (FileManager.default.fileExists(atPath: path)) {
                            print("File exists...Removing.")
                            do {
                            try FileManager.default.removeItem(atPath: path)
                            } catch {
                                print("Failed to remove file at path \(path)")
                            }
                        }
                        }
                        removeFile(atPath: "/Applications/Tapp.app")
                        Alamofire.download("https://apps.carspotter.ca/Tapp/releases/\(v.applications[0].latestVersion)/Tapp.app", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, to: DownloadRequest.suggestedDownloadDestination(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: .allDomainsMask)).downloadProgress(closure: { (Progresss) in
                            print(Progresss)
                            progressIndicator.doubleValue = Progresss.fractionCompleted
                            
                        }).response(completionHandler: { (response) in
                            if ((response.error) != nil) {
                                
                            } else {
                                self.TappText.textColor = .systemGreen
                                self.TappText.stringValue = "Complete"
                            do {
                                
                                print(response.destinationURL!.path)
                            try SSZipArchive.unzipFile(atPath: response.destinationURL!.path, toDestination: "/Applications/", overwrite: true, password: nil)
                                removeFile(atPath: response.destinationURL!.path)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    NSWorkspace.shared.open(URL(fileURLWithPath: "/Applications/Tapp.app"))
                                    NSApplication.shared.terminate(nil)
                                }
                                
                            } catch let error{
                                print("Failed to unzip \(error)")
                            }

                            }
                        })
                        
                        // DONE: ADD AUTOMATIC UPDATE
                    }
                    else {
                        self.view.window!.setIsVisible(true)
                    }
                }
                group.leave()
            }
        }
        // 1. Complete
        
        // 2A. Check if there is a saved access token (TRUE)
        group.notify(queue: .main) {
            do {
                guard let token = try self.keychain.getString(UserDefaults.standard.string(forKey: "userEmail") ?? "token") else {
                    throw NSError(domain: "self", code: 403, userInfo: nil)
                }
                self.getVehicles(token)
            } catch {
                print("No saved token")
            }
        }
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.styleMask.insert(.fullSizeContentView)
        self.view.window?.styleMask.remove(.titled)
        self.view.window?.isMovableByWindowBackground = true
        self.view.window!.backgroundColor = .clear
        self.view.window!.isOpaque = true
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let menuController = (segue.destinationController as! SplitView).children[0] as! MenuController
        //Explain what's going on to Menu
        menuController.vehicles = self.vehicleResponse
    }
    
    
    
    @IBOutlet weak var TappText: NSTextField!
    @IBOutlet weak var EmailField: NSTextField!
    @IBOutlet weak var PasswordField: NSTextField!
    @IBOutlet weak var LoginButton: NSButton!
    @IBOutlet weak var StayLoggedInCheckBox: NSButton!
    
    
    @IBOutlet weak var Background: NSVisualEffectView!
    var vehicleResponse: Vehicles? = nil
    
    
    func getVehicles(_ token:String) {
        
        /*Alamofire.request(URL(string: "https://apps.carspotter.ca/Tapp/TestData")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseVehicles { (response) in
            if(response.error == nil) {
                self.vehicleResponse = response.result.value
                
                self.performSegue(withIdentifier: "toMain", sender: self)
                self.view.window!.close()
            } else {
                print(response.error!)
            }
         
        }*/
    
        

        Alamofire.request(URL(string: "https://owner-api.teslamotors.com/api/1/vehicles")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"]).responseVehicles { (response) in
            if(response.error == nil) {
                self.vehicleResponse = response.result.value
                headers = ["Authorization": "Bearer \(token)"]
                self.performSegue(withIdentifier: "toMain", sender: self)
                self.view.window!.close()
            } else {
                print(response.error!)
            }
            
            }.responseJSON { (resp) in
                print(resp)
        }
    
        
       
        
        
    }
    
    func PerformLogin(_ Email: String, _ Password: String) {
        let params : Parameters = ["grant_type":"password","client_id":"81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384","client_secret":"c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3","email":Email,"password":Password]
        Alamofire.request("https://owner-api.teslamotors.com/oauth/token", method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: [:]).responseAuthentication { (response) in
            
            if(response.error == nil) {
                if let token = response.result.value?.accessToken {
                    do {
                        try self.keychain.set(token,key: Email)
                        UserDefaults.standard.set(Email, forKey: "userEmail")
                        self.getVehicles(token)
                    } catch {
                        print("error setting token")
                    }
                }
            } else {
                print(response.error!)
            }
            }
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if(self.EmailField.stringValue.isEmpty || self.PasswordField.stringValue.isEmpty) {
            print("error")
        } else if (!self.EmailField.stringValue.isEmpty && !self.PasswordField.stringValue.isEmpty) {
            PerformLogin(self.EmailField.stringValue, self.PasswordField.stringValue)
        }
    }
    
}
