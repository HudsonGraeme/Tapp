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

class Login: NSViewController {
    
    let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer!.cornerRadius = 10.0
        // 1. Contact Carspotter and compare versions (42-59)
        Alamofire.request(URL(string: "http://api.carspotter.ca/index.php/Applications?transform=1")!).responseVersion { (response) in
            
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
            }
        }
        // 1. Complete
        
        // 2A. Check if there is a saved access token (TRUE)
        do {
            guard let token = try keychain.get("token") else {
                throw NSError(domain: "self", code: 403, userInfo: nil)
            }
            getVehicles(token)
            } catch {
                print("caught")
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
        //let selectController = segue.destinationController as! SelectVehicle
        //Explain what's going on to SelectVehicle
    }
    
    
    
    @IBOutlet weak var TappText: NSTextField!
    @IBOutlet weak var Background: NSVisualEffectView!
    
    
    
    func getVehicles(_ token:String) {
        Alamofire.request(URL(string: "https://owner-api.teslamotors.com/api/1/vehicles")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"]).responseVehicles { (response) in
            
        }
    }
    
    
}
