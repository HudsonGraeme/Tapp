//
//  login.swift
//  Tapp
//
//  Created by Hudson Graeme on 2017-01-07.
//  Copyright © 2017 Carspotter Daily. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import SwiftyJSON

class login: NSViewController, NSTextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate = self;
    }
    
    @IBOutlet weak var email: NSTextField! //email text field
    @IBOutlet weak var password: NSSecureTextField! //password field
    @IBOutlet weak var errorLabel: NSTextField!
    
    func textFieldShouldReturn(email: NSTextField) -> Bool {
        self.email.resignFirstResponder()
        return false                                        //attempt to close textbox on clickaway..
    }
    
    func passFieldShouldReturn(password: NSSecureTextField) -> Bool {
        self.password.resignFirstResponder()
        return false
    }
    
    
    
    
    @IBAction func login(_ sender: Any) { //login button pressed
        let pass = self.password.stringValue //make the strings
        let mail = self.email.stringValue
        
                let url = URL(string: "https://owner-api.teslamotors.com/oauth/token?grant_type=password&client_id=e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e&client_secret=c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220&email=\(mail)&password=\(pass)")
        
        //Fire it up
        NSLog("about to send request")
        let task = Alamofire.request(url!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let data = response.result.value
                print("HERE: \(response)")
                if let result = response.result.value {
                    let json = JSON(data!)
                    var token = json["access_token"]
                   NSLog("Got token \(token)")
                    
                    func getvehicle() {
                        NSLog("getvehicle called")
                        let headers = [
                            "Authorization": "Bearer \(token)"
                        ]
                        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles")
                        print(url! as URL)
                        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                            print("Progress: \(progress.fractionCompleted)")
                            }
                            .validate { request, response, data in
                                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                                return .success
                            }
                            .responseJSON { response in
                                let data = response.result.value
                                if data != nil {
                                let json = JSON(data!)
                                let vehicleid = json["response"][0]["id"]
                                let vehiclecount = json["count"]
                                print(vehiclecount)
                                debugPrint(data!)
                                
                        
                            NSLog("Flashlights Called")
                            let headers = [
                                "Authorization": "Bearer \(token)"
                            ]
                            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/flash_lights")
                            print(url! as URL)
                        
                                    let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                                let data = response.result.value
                                print("Here: \(response)")
                                print(headers)
                                }
                        }
                        }
                    }
                
                
                                if let status = response.response?.statusCode {
                                    if status == 200 {
                                        NSLog("200 is called")
                                        print("success")
                                        self.errorLabel.stringValue = "You're in!"
                                        getvehicle()
                                        
                                        
                                    
                                    }
                                
                                    switch(status) {
                                    case 200:
                                        print("200")
                                        getvehicle()
                                    case 401:
                                        print("401 - Forbidden.. Email or Password incorrect")
                                        self.errorLabel.stringValue = "Invalid login info"
                                    case 404:
                                        self.errorLabel.stringValue = "Select a car, any car"
                                    default:
                                        print("Here is the error: \(status)")
                                        self.errorLabel.stringValue = "Unknown error \(status)"
                                    
                                    }
                            
                        
                    }
                
            }
        }
    }
}

