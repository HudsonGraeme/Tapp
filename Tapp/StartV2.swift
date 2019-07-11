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

class Login: NSViewController {
    
    let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Contact Carspotter and compare versions (42-59)
        Alamofire.request(URL(string: "http://api.carspotter.ca/index.php/Applications?transform=1")!).responseVersion { (response) in
            
            let versionReadable = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! NSString)
            let version = NumberFormatter().number(from: versionReadable.replacingCharacters(in: NSRange(location: 3, length: 1), with: ""))!.doubleValue
            
            if let v = response.result.value {
                if (v.applications[0].latestVersion > version){
                    print("yes")
                    let response = Alert("New Software Available!", "A new version of Tapp is available (\(v.applications[0].latestVersion)). Would you like to update from your current version (\(versionReadable))?", .informational, 2, ["Update", "Cancel"])
                    if (response == 1001) {
                        NSWorkspace.shared.open(URL(string: "https://github.com/HudsonGraeme/Tapp/releases")!)
                        // TODO: ADD AUTOMATIC UPDATE
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
    
    //Comment! 
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let selectController = segue.destinationController as! SelectVehicle
        //Explain what's going on to SelectVehicle
    }
    
    func getVehicles(_ token:String) {
        Alamofire.request(URL(string: "https://owner-api.teslamotors.com/api/1/vehicles")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"]).responseVehicles { (response) in
            
        }
    }
    
    
}
