//
//  start.swift
//  Tapp
//
//  Created by s on 2017-10-09.
//  Copyright © 2017 Carspotter Daily. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import SwiftyJSON
import CoreWLAN
import KeychainAccess
import FlatButton
import TeslaSwift

class start: NSViewController, NSUserNotificationCenterDelegate {
    
    let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserNotificationCenter.default.delegate = self
        print(currentSSIDs().first)
        let SSID = currentSSIDs().first
        self.tapp.font = NSFont(name: "KaushanScript-Regular", size: 72.0)
        var version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! NSString
        version = version.replacingCharacters(in: NSRange(location: 3, length: 1), with: "") as NSString
        let versio = (version as! NSString).replacingCharacters(in: NSRange(location: 3, length: 1), with: "") as NSString
        
        print(version)
        _ = Alamofire.request(URL(string: "http://api.carspotter.ca/index.php/Applications?transform=1")!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: CVD.headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
            let data = response.result.value
            let json = JSON(data)
            print(json)
            let v = json["Applications"][0]["latestVersion"].doubleValue
            print("App version: \(version), Latest is \(v)")
                //I WIN I WIN I WIN HAHAHAHAHAHAHAHAHAHAHAH
            if(v == version) {
                print("Up to date")
            } else if (v > version){
                let response = Alert("New Software Available!", "A new version of Tapp is available (\(v)). Would you like to update from your current version (\(version))?", .informational, 2, ["Update", "Cancel"])
                switch(response) {
                case 1000:
                    print("Cancelled")
                case 1001:
                    NSWorkspace.shared.open(URL(string: "https://github.com/HudsonGraeme/Tapp/releases")!)
                default:
                    print("lit")
                }
            }
        }
        if(!UserDefaults.standard.bool(forKey: "EULA") && !CVD.EULA) {
            
        } else {
            do {
                let token = try keychain.get("token")
                if(token != nil) {
                let notification = NSUserNotification()
                notification.actionButtonTitle = "OK"
                notification.title = "Logging in..."
                notification.informativeText = "Syncing..."
                notification.identifier = "LoggedInNotification"
                NSUserNotificationCenter.default.deliver(notification)
                CVD.SavedToken = true
                CVD.Token = try keychain.get("token")
                CVD.headers = [
                    "Authorization": "Bearer \(CVD.Token!)"
                ]
                headers = CVD.headers
                print(CVD.headers)
                print(CVD.Token!)
                getVehicles()
                } else {
                    throw NSError(domain: "keychain failure", code: 101, userInfo: nil)
                }
            }
            catch {
                print("shmello")
                CVD.SavedToken = false
            }
    }
}
    override func viewDidAppear() {
        super.viewDidAppear()
        self.tapp.font = NSFont(name: "KaushanScript-Regular", size: 72.0)
        self.email.textColor = NSColor.black
        self.shwtk.slideInFromRight()
        
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.styleMask.insert(.fullSizeContentView)
        self.view.window?.styleMask.remove(.titled)
        self.view.window?.isMovableByWindowBackground = true
        self.view.window!.backgroundColor = .clear
        self.view.window!.isOpaque = true
        
        self.Background.wantsLayer = true
        self.Background.layer?.cornerRadius = 16.0
        
        self.shwpswd.slideInFromRight()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        if(!UserDefaults.standard.bool(forKey: "EULA") && !CVD.EULA) {
            self.performSegue(withIdentifier: "ToEULA", sender: self)
            self.view.window?.close()
        } else {
            
        }
    }
    var headers = [
    "Bearer":""
]
    
    @IBOutlet weak var tapp: NSTextField!
    @IBOutlet weak var email: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
    @IBOutlet weak var acctok: NSSecureTextField!
    @IBOutlet weak var login: NSButton!
    @IBOutlet weak var shwtk: NSButton!
    @IBOutlet weak var shwpswd: NSButton!
    @IBOutlet weak var pswdcell: NSSecureTextFieldCell!
    @IBOutlet weak var tkcell: NSSecureTextFieldCell!
    @IBOutlet weak var or: NSTextField!
    @IBOutlet weak var stayLogged: NSButton!
    @IBOutlet weak var visPswd: NSTextField!
    @IBOutlet weak var visAcc: NSTextField!
    @IBOutlet weak var Background: NSVisualEffectView!
    
   func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    var vehicleAttempts = 0
    
    func getVehicles() {
        
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/")
        let _ = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: CVD.headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
                /*let path = Bundle.main.path(forResource: "TstData", ofType: "JSON")
                var data = Data()
                 do
                 { data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
                 } catch {
                    
                }*/
                let data = response.result.value
                if(data != nil) {
                let json = JSON(data)
                
                print(json)
                switch response.result {

                case .success:
                    if(json["response"] != JSON.null) {
                    if data != nil {
                        CVD.numOfVehicles = json["count"].intValue
                        for i in 1 ... CVD.numOfVehicles {
                            print(i)
                            let x = i - 1
                            CVD.optionCodes.append(json["response"][x]["option_codes"].stringValue)
                            CVD.vehicleIDs.append(json["response"][x]["id_s"].intValue)
                        }
                    self.performSegue(withIdentifier: "LogToSelect", sender: nil)
                        self.view.window?.close()
                    }
                    }
                default:
                print("data_request defaulted")
                    self.or.textColor = .red
                    self.or.stringValue = "Please re-login"
                    self.or.slideInFromRight()
                self.tapp.stringValue = "Tapp"
                self.tapp.slideInFromLeft()
                self.acctok.isHidden = false
                self.password.isHidden = false
                self.shwpswd.isHidden = true
                self.visAcc.isHidden = true
                self.acctok.isHidden = false
                self.email.isHidden = false
                self.shwtk.isHidden = false
                self.stayLogged.slideInFromRight()
        }
                }
                else {
                    if(self.vehicleAttempts >= 2) {
                        self.or.stringValue = "Unable to load data."
                        self.or.stringValue = "Please re-login"
                        self.or.slideInFromRight()
                        self.tapp.stringValue = "Tapp"
                        self.tapp.slideInFromLeft()
                        self.acctok.isHidden = false
                        self.password.isHidden = false
                        self.shwpswd.isHidden = true
                        self.visAcc.isHidden = true
                        self.acctok.isHidden = false
                        self.email.isHidden = false
                        self.shwtk.isHidden = false
                        self.stayLogged.slideInFromRight()
                    } else {
                    self.or.textColor = .red
                    self.or.stringValue = "Unknown Error.. Retrying"
                    self.or.slideInFromRight()
                        self.vehicleAttempts += 1
                        self.getVehicles()
                    }
                }
    }
    }
    
    
    
    
    
    @IBAction func shwpswd(_ sender: Any) {
        if(shwpswd.state.rawValue == 1) {
            self.visPswd.stringValue = self.password.stringValue
            self.password.isHidden = true
            self.visPswd.isHidden = false
        }
        else if(shwpswd.state.rawValue == 0) {
            self.password.stringValue = self.visPswd.stringValue
            self.password.isHidden = false
            self.visPswd.isHidden = true
        }
    }
    @IBAction func shwtk(_ sender: Any) {
        if(shwtk.state.rawValue == 1) {
            self.visAcc.stringValue = self.acctok.stringValue
            self.acctok.isHidden = true
            self.visAcc.isHidden = false
        }
        else if(shwtk.state.rawValue == 0) {
            self.acctok.stringValue = self.visAcc.stringValue
            self.acctok.isHidden = false
            self.visAcc.isHidden = true
        }
        
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        if(self.acctok.stringValue == "" && self.visAcc.stringValue == "") {
        // Login button pressed
        print("Triggered")
            print("Keychain is nil")
            var pass = ""
            let mail = self.email.stringValue
            if(self.acctok.stringValue == "" && self.visAcc.stringValue == "") {
            print("accs are nil")
            if(self.password.stringValue == "" && self.visPswd.stringValue != "") {
                pass = self.visPswd.stringValue
                if(mail != "" && pass != "") {
                    logn(mail, pass)
                }
                print("if")
            }
            else if(self.visPswd.stringValue == "" && self.password.stringValue != "") {
                pass = self.password.stringValue
                print("else vis")
                if(mail != "" && pass != "") {
                logn(mail, pass)
                }
            }
            else if(self.password.stringValue == "" && self.visPswd.stringValue == "") {
                print("Both nil")
                self.or.stringValue = "Please enter your info"
                self.or.slideInFromRight()
            }
            else if(self.password.stringValue != "" && self.visPswd.stringValue != "") {
                pass = self.password.stringValue
                print("Both good")
                if(mail != "" && pass != "") {
                    logn(mail, pass)
                }
            }
            else {
                print("password is else, doing nothing")
                }
            }
    }
        else {
            print("access token entered")
            print("Token must be something..")
            if(self.acctok.stringValue != "" && self.visAcc.stringValue != "") {
                print("Both token fields aren't empty")
                checkToken(self.acctok.stringValue)
            }
            else if(self.acctok.stringValue == "" && self.visAcc.stringValue != "") {
                print("visAcc is the field")
                checkToken(self.visAcc.stringValue)
            }
            else if(self.acctok.stringValue != "" && self.visAcc.stringValue == "") {
                print("acctok it is")
                checkToken(self.acctok.stringValue)
            }
        }
}
    
    
    
    func logn(_ mail:String?,_ pass:String?) {
        print("logn")
        let notification = NSUserNotification()
        notification.actionButtonTitle = "OK"
        notification.title = "Logging in..."
        notification.informativeText = "Please wait while we contact Tesla's servers..."
        notification.identifier = "LoggedInNotification"
        NSUserNotificationCenter.default.deliver(notification)
        let url = URL(string: baseURL+AuthURI+"email=\(mail!)&password=\(pass!)")
        print("setting url OK  ", url!)
            let _ = Alamofire.request(url!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print("response in")
                let data = response.result.value
                let json = JSON(data as Any)
                print(json)
                let status = response.response?.statusCode
                
                switch(status) {
                case 200:
                    print("200")
                    CVD.isLoggedInWithToken = false
                    self.or.stringValue = "Success!"
                    self.or.slideInFromRight()
                    switch(convertFromNSControlStateValue(self.stayLogged.state)){
                    case 1:
                        do {
                            try self.keychain.set(json["access_token"].stringValue, key: "token")
                            print(json["access_token"].stringValue)
                            CVD.Token = json["access_token"].stringValue
                            self.getVehicles()
                        }
                        catch {
                            print("Failed to save token")
                        }
                        return
                    case 0:
                        print("user didn't want to save the token")
                        do {
                            CVD.Token = json["access_token"].stringValue
                            self.getVehicles()
                        }
                        catch {
                            print("Failed to delete data")
                        }
                        return
                    default:
                        print("Switch defaulted for some reason")
                    }
                    
                    
                case 400:
                    print("400 - Email or pass empty")
                    self.or.textColor = NSColor.red
                    self.or.stringValue = "Email or Password field left blank"
                case 401:
                    print("401 - Forbidden.. Email or Password incorrect")
                    self.or.textColor = NSColor.red
                    self.or.stringValue = "Invalid login info"
                case 404:
                    print("404")
                    self.or.textColor = NSColor.red
                    self.or.stringValue = "My Bad.. Contact Dev"
                case nil:
                    print("nil")
                    self.or.textColor = NSColor.red
                    self.or.stringValue = "No Wifi!"
                default:
                    print("Here is the error: \(status)")
                    self.or.stringValue = "Unknown error \(status)"
                    
                }
                
        }
    }
    
    
    
    
    
    public func checkToken(_ token: String!) {
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        print(token)
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/")
        Alamofire.request(url!).responseVehicles(completionHandler: { response in
                

                    
                
                    if let data = response.result.value {
                        
                    }
                    else {
                    print("Token Check failure")
                    self.or.textColor = NSColor.red
                    self.or.stringValue = "Invalid Token"
                    self.or.slideInFromRight()
                    self.acctok.resignFirstResponder()
                    }
        })
    
}
    
    
    
    
    
    func currentSSIDs() -> [String] {
        let client = CWWiFiClient.shared()
        return client.interfaces()?.compactMap { interface in
            return interface.ssid()
            } ?? []
    }
    
    
    
    
    
}

class SplitView : NSSplitViewController {
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.ReloadData), userInfo: nil, repeats: true)
    }
    var timer = Timer()
    
    @objc func ReloadData() {
        print("SHMELLO")
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data")
        let _ = Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: CVD.headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
            progress in
            }
            .validate { request, response, data in
                return .success
                
            }
            .responseJSON {
                response in
                let data = response.result.value
                if(data != nil) {
                    let json = JSON(data!)
                    CVD.Data = JSON.null
                    CVD.Data = json
                }
                else {
                    print("error")
                }
        }
            .response(completionHandler: { response in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATIONKEY), object: nil)
                
            }
        
        )
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSControlStateValue(_ input: NSControl.StateValue) -> Int {
	return input.rawValue
}
