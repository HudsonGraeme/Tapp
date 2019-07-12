//
//  Plaid.swift
//  Tapp
//
//  Created by s on 2017-11-19.
//  Copyright © 2017 Carspotter Daily. All rights reserved.
//

import Foundation
import Cocoa
import SwiftyJSON
import Alamofire
import MapKit


let NOTIFICATIONKEY = "Tapp2"
@available(OSX 10.12.2, *)
class Plaid: NSViewController, NSUserNotificationCenterDelegate {
    @IBOutlet weak var Lock: NSButton!
    @IBOutlet weak var RStart: NSButton!
    @IBOutlet weak var VehicleImage: NSImageView!
    @IBOutlet weak var FlashLights: NSButton!
    @IBOutlet weak var Horn: NSButton!
    @IBOutlet weak var Trunk: NSButton!
    @IBOutlet weak var Frunk: NSButton!
    @IBOutlet weak var ChargePort: NSButton!
    @IBOutlet weak var VIN: NSTextField!
    @IBOutlet weak var ChargeLabel: NSTextField!
    @IBOutlet weak var Shift: NSTextField!
    
    //Touchbar
    @IBOutlet weak var TbChargePort: NSTouchBarItem!
    @IBOutlet weak var TbLock: NSTouchBarItem!
    @IBOutlet weak var TbTrunk: NSTouchBarItem!
    @IBOutlet weak var TbFrunk: NSTouchBarItem!
    @IBOutlet weak var TbHorn: NSTouchBarItem!
    @IBOutlet weak var TbFlashLights: NSTouchBarItem!
    @IBOutlet weak var TbRStart: NSTouchBarItem!
    //End Touchbar
    
    var token = CVD.Token!
    var vehicleID = CVD.vehicleIDs[CVD.SelectedVehicle]
    var headers = CVD.headers

    let v = CVD.SelectedVehicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.vehicleID = CVD.vehicleIDs[v]
        if(UserDefaults.standard.value(forKey: "GraphXMax") != nil) {
            CVD.GraphSavedValues = UserDefaults.standard.integer(forKey: "GraphXMax")
        }
            let json = CVD.Data
        let isLocked = json["response"]["vehicle_state"]["locked"].boolValue
        if(isLocked == true) {
            print("Vehicle is locked")
            self.Lock.title = "Unlock"
        }
        else {
            print("Vehicle is Unlocked")
            self.Lock.title = "Lock"
        }
        NSUserNotificationCenter.default.delegate = self
        self.WakeVehicle()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer?.backgroundColor = CVD.Theme
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.getcardata()
        let json = CVD.Data
        NotificationCenter.default.addObserver(self, selector: #selector(self.getcardata), name: NSNotification.Name(rawValue: NOTIFICATIONKEY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.ColorChange(_:)), name: NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        
        let latitude:CLLocationDegrees = json["response"]["drive_state"]["latitude"].doubleValue
         let longitude:CLLocationDegrees = json["response"]["drive_state"]["longitude"].doubleValue
        let loc = CLLocation(latitude: latitude, longitude: longitude)
        

        let jsonCharge = json["response"]["charge_state"]["charging_state"].stringValue
        if(jsonCharge == "Complete") {
            self.ChargeLabel.stringValue = "Charging Complete"
            self.ChargeLabel.textColor = .systemGreen
        } else if(jsonCharge == "Connected") {
            self.ChargeLabel.stringValue = "Charge Cable Connected"
            self.ChargeLabel.textColor = .systemBlue
        } else if(jsonCharge == "null") {
            self.ChargeLabel.stringValue = "Disconnected (assumed)"
            self.ChargeLabel.textColor = .systemOrange
        } else if(jsonCharge == "Supercharging") {
            self.ChargeLabel.stringValue = "Supercharging"
            self.ChargeLabel.textColor = .systemPurple
        } else if(jsonCharge == "Disconnected"){
            self.ChargeLabel.stringValue = "Charge Cable Disconnected"
            self.ChargeLabel.textColor = .systemGreen
        } else {
            self.ChargeLabel.stringValue = jsonCharge
        }
        var driveState = json["response"]["drive_state"]["shift_state"].stringValue
        if(json["response"]["drive_state"]["shift_state"] != JSON.null) {
        driveState = json["response"]["drive_state"]["shift_state"].stringValue
        } else {
            driveState = "null"
        }
        let speed = json["response"]["drive_state"]["speed"].intValue
        let units = json["response"]["gui_settings"]["gui_distance_units"].stringValue
        if(driveState != "null") {
            switch driveState {
            case "D":
                self.ChargeLabel.stringValue = "Vehicle is driving at \(speed)\(units)"
            case "R":
                self.ChargeLabel.stringValue = "Vehicle is reversing at \(speed)\(units)"
            case "N":
                self.ChargeLabel.stringValue = "Vehicle is in neutral, travelling at \(speed)\(units)"
            default:
               self.ChargeLabel.stringValue = "Vehicle is parked, "
            }
             self.Shift.stringValue = driveState
        } else {
            self.Shift.stringValue = "P"
        }
        let geoc = CLGeocoder()
        geoc.reverseGeocodeLocation(loc) { placemarks, error in
            if let e = error {
            } else {
                let placeArray = placemarks
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                guard let address = placeMark.addressDictionary else {
                    return
                }
                let arr = address["FormattedAddressLines"] as! NSArray
                self.ChargeLabel.stringValue += (" at " + (arr[0] as! String))
            }
        }

    }
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    

    var timer = Timer()
    
    @objc func ColorChange(_ notification: NSNotification) {
        self.view.layer?.backgroundColor = (notification.userInfo!["color"] as! CGColor)
    }
    @objc func getcardata(){
        print("hello")
                let json = CVD.Data
        self.VIN.stringValue = "VIN : \(json["response"]["vin"].stringValue)"
                let vehMod = json["response"]["vehicle_config"]["car_type"].stringValue
                CVD.VehicleTrims.append(vehMod.last!)
                if(json["response"]["vehicle_state"]["valet_mode"] == "true") {
                    print("valet mode")
                }
                else if(json["response"]["vehicle_state"]["valet_mode"] == "false") {
                    print("no valet mode")
                }
                if(json["response"]["vehicle_config"]["can_actuate_trunks"].boolValue) {
                    self.Frunk.isHidden = false
                    self.Trunk.isHidden = false
                } else {
                    self.Frunk.isHidden = true
                    self.Trunk.isHidden = true
                    }

                    if(json["response"]["drive_state"]["shift_state"] == JSON.null || json["response"]["drive_state"]["shift_state"].stringValue == "P") {
                        
                    }
                    else {
                        self.RStart.isHidden = true
                    }
        if(json["response"]["charge_state"]["charging_state"].stringValue == "Charging" || json["response"]["charge_state"]["charging_state"].stringValue == "Complete" || json["response"]["charge_state"]["charging_state"].stringValue == "Connected") {
            self.ChargePort.isHidden = true
        }
        
                    /*
                     Changes App Icon yeh
                     */
                    let percentage = json["response"]["charge_state"]["usable_battery_level"].intValue
                    if(percentage <= 0) {
                        NSApplication.shared.applicationIconImage = #imageLiteral(resourceName: "NoBattery")
                    }
                    else if(percentage >= 0 && percentage <= 20) {
                        NSApplication.shared.applicationIconImage = #imageLiteral(resourceName: "LowBattery")
                    }
                    else if(percentage > 20 && percentage <= 40) {
                        NSApplication.shared.applicationIconImage = #imageLiteral(resourceName: "2Battery")
                    }
                    else if(percentage > 40 && percentage <= 60) {
                        NSApplication.shared.applicationIconImage = #imageLiteral(resourceName: "3Battery")
                    }
                    else if(percentage > 60 && percentage <= 80) {
                        NSApplication.shared.applicationIconImage = #imageLiteral(resourceName: "4Battery")
                    }
                    else if(percentage > 80 && percentage <= 100) {
                        NSApplication.shared.applicationIconImage =  #imageLiteral(resourceName: "FullBattery")
                    }
       self.getimg(1)
        CVD.BatteryImage = NSApplication.shared.applicationIconImage
        }
    
    

    
    func getimg(_ Reload: Int?) {
        let options = CVD.optionCodes[v]
        let model = CVD.VehicleTrims[v]
        let url = URL(string:"https://www.tesla.com/configurator/compositor/?model=m\(model)&view=STUD_SEAT_ABOVE&options=\(options)&bkba_opt=1&size=1920")
        let _ = Alamofire.request(url!).responseImage { response in
            let data = response.result.value
            if(data != nil) {
                let img = data
            self.VehicleImage.image = img
                
            CVD.VehicleAbov = data!
            self.VehicleImage.wantsLayer = true
            self.VehicleImage.layer?.backgroundColor = NSColor.darkGray.cgColor
                if(Reload == 0) {
                let notification = NSUserNotification()
                notification.title = "Logged in successfully"
                notification.contentImage = data
                notification.informativeText = "Thank you for using Tapp :)"
                NSUserNotificationCenter.default.deliver(notification)
                NSUserNotificationCenter.default.removeDeliveredNotification(NSUserNotificationCenter.default.deliveredNotifications[0]) //Deletes login noty
                }
            }
        }
    }
    
    
    func WakeVehicle() {
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/wake_up")
        let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
        }
    }
    
    @IBAction func Lock(_ sender: Any) {
            let token = CVD.Token
            let vehicleid = CVD.vehicleIDs[v]
            let headers = [
                "Authorization": "Bearer \(token!)"
            ]
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data")
            let _ = Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
                progress in
                }
                .validate { request, response, data in
                    return .success
                }
                .responseJSON {
                    response in
                    let data = response.result.value
                    let json = JSON(data!)
                    CVD.Data = JSON.null
                    CVD.Data = json
                    let isLocked = json["response"]["vehicle_state"]["locked"].boolValue
                    if(isLocked == true) {
                        print("Button pressed, vehicle currently locked")
                        let urll = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(self.vehicleID)/command/door_unlock")
                        let _ = Alamofire.request(urll!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                            print(response)
                            self.Lock.title = "Lock"
                        }
                    }
                    else {
                        print("Button pressed, vehicle currently unlocked")
                        let urll = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(self.vehicleID)/command/door_lock")
                        let _ = Alamofire.request(urll!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                            print(response)
                            self.Lock.title = "Unlock"
                        }
                    }
        }
    }
    
    
    
    
    @IBAction func RStart(_ sender: Any) {
        let Alert = NSAlert()
        let tField = NSSecureTextField(frame: NSMakeRect(0, 0, 500, 20))
        Alert.accessoryView = tField
        Alert.messageText = "Would you like to remotely start your vehicle?"
        Alert.informativeText = "By clicking either of the \"Yes\" options, you are enabling keyless driving in your vehicle for two minutes."
        Alert.addButton(withTitle: "Cancel")
        Alert.addButton(withTitle: "Yes, Start and Unlock my vehicle")
        Alert.addButton(withTitle: "Yes, Start my Vehicle")
        Alert.layout()
        let response = Alert.runModal()
        if(response.rawValue == 1001) {
            print(1001)
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/remote_start_drive?password=\(tField.stringValue)")
            
            let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                let json = CVD.Data
                let isLocked = json["response"]["vehicle_state"]["locked"].boolValue
                if(isLocked == true) {
                    print("Remote Start w/unlock, vehicle currently locked")
                    let urll = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(self.vehicleID)/command/door_unlock")
                    let _ = Alamofire.request(urll!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
                        self.Lock.title = "Lock"
                    }
                }
            }
        } else if(response.rawValue == 1002) {
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/remote_start_drive?password=\(tField.stringValue)")
            
            let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                let data = response.result.value
                let json = JSON(data!)
                
                print(json, response)
                
            }
        } else if(response.rawValue == 1000) {
            print(1000)
        }

    }
    
    @IBAction func FlashLights(_ sender: Any) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/flash_lights")
        let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            
        }
    }
    
    @IBAction func Horn(_ sender: Any) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/honk_horn")
        let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            
        }
    }
    
    
    @IBAction func Frunk(_ sender: Any) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/actuate_trunk")
        
        let _ = Alamofire.request(url!, method: .post, parameters: ["which_trunk":"front"], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
        }
    }
    
    @IBAction func Trunk(_ sender: Any) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/actuate_trunk")
        
        let _ = Alamofire.request(url!, method: .post, parameters: ["which_trunk":"rear"], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        }
    }
    
    
    @IBAction func ChargePort(_ sender: Any) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/command/charge_port_door_open")
        
        let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        }
    }
    
    
}
