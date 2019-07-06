//
//  Subzero.swift
//  Tapp
//
//  Created by s on 2018-02-04.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import FlatButton

class Subzero: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.onLoad()
        self.HVACImage.toolTip = "Turn the HVAC on"
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        self.onLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.onLoad), name: NSNotification.Name(rawValue: NOTIFICATIONKEY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.ColorChange(_:)), name: NSNotification.Name(rawValue: "ChangeColor"), object: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer?.backgroundColor = CVD.Theme
    }
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer.invalidate()
    }
    
    @objc func ColorChange(_ notification: NSNotification) {
        self.view.layer?.backgroundColor = notification.userInfo!["color"] as! CGColor
    }

    @IBOutlet weak var DriverTempLabel: NSTextField!
    @IBOutlet weak var PassengerTempLabel: NSTextField!
    @IBOutlet weak var InteriorTemperature: NSLevelIndicator!
    @IBOutlet weak var ExteriorTemperature: NSLevelIndicator!
    @IBOutlet weak var ExtTemperatureLabel: NSTextField!
    @IBOutlet weak var IntTemperatureLabel: NSTextField!
    @IBOutlet weak var HVACImage: NSImageView!
    @IBOutlet weak var DriverUp: FlatButton!
    @IBOutlet weak var DriverDown: FlatButton!
    @IBOutlet weak var PassengerUp: FlatButton!
    @IBOutlet weak var PassengerDown: FlatButton!
    @IBOutlet weak var HVACControl: FlatButton!
    @IBOutlet weak var HSeats: NSTextField!
    @IBOutlet weak var SeatLbl: NSTextField!
    
    var timer = Timer()
    let v = CVD.SelectedVehicle
    var DriverTemp = Int()
    var PassengerTemp = Int()
    
    let units = CVD.Data["response"]["gui_settings"]["gui_temperature_units"].stringValue.uppercased()

    @objc func onLoad() {
        let json = CVD.Data
        if(json["response"]["climate_state"]["is_climate_on"].boolValue) {
            self.HVACControl.title = "Turn HVAC Off"
        } else {
            self.HVACControl.title = "Turn HVAC On"
        }
            let units = json["response"]["gui_settings"]["gui_temperature_units"].stringValue.uppercased()
        var interiorTemp = json["response"]["climate_state"]["inside_temp"].doubleValue
        if(units == "F") {
            interiorTemp = (json["response"]["climate_state"]["outside_temp"].doubleValue * (9/5)) + 32
        }
        
        var exteriorTemp = json["response"]["climate_state"]["outside_temp"].doubleValue
        if(units == "F"){
            exteriorTemp = (json["response"]["climate_state"]["outside_temp"].doubleValue * (9/5)) + 32
        }
            self.InteriorTemperature.doubleValue = interiorTemp
            self.IntTemperatureLabel.stringValue = "\(interiorTemp)°\(units)"
            self.ExteriorTemperature.doubleValue = exteriorTemp
            self.ExtTemperatureLabel.stringValue = "\(exteriorTemp)°\(units)"
        var DriverTemp = json["response"]["climate_state"]["driver_temp_setting"].intValue
        if(units == "F") {
            DriverTemp = (json["response"]["climate_state"]["driver_temp_setting"].intValue * (9/5))
        }
        var PassengerTemp = json["response"]["climate_state"]["passenger_temp_setting"].intValue
        if(units == "F") {
            PassengerTemp = (json["response"]["climate_state"]["passenger_temp_setting"].intValue * (9/5)) + 32
        }
            self.DriverTempLabel.stringValue = "\(DriverTemp)°\(units)"
            self.DriverTemp = DriverTemp
            self.PassengerTempLabel.stringValue = "\(PassengerTemp)°\(units)"
            self.PassengerTemp = PassengerTemp
        let FLHeat = json["response"]["climate_state"]["seat_heater_left"].boolValue
        let FRHeat = json["response"]["climate_state"]["seat_heater_right"].boolValue
        let RLHeat = json["response"]["climate_state"]["seat_heater_left"].boolValue
        let RRHeat = json["response"]["climate_state"]["seat_heater_rear_right"].boolValue
        let RMHeat = json["response"]["climate_state"]["seat_heater_rear_center"].boolValue
        let RRBHeat = json["response"]["climate_state"]["seat_heater_right_back"].boolValue
        let RLBHeat = json["response"]["climate_state"]["seat_heater_left_back"].boolValue
        let SWheelHeat = json["response"]["climate_state"]["steering_wheel_heater"].boolValue
        if(FLHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Front Left"
        }
        if(FRHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Front Right"
        }
        if(RLHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Rear Left"
        }
        if(RRHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Rear Right"
        }
        if(RMHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Rear middle"
        }
        if(RLBHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Rear Left Back"
        }
        if(RRBHeat) {
            if(self.HSeats.isHidden) {
                self.HSeats.isHidden = false
            }
            self.SeatLbl.stringValue += "Rear Right Back"
        }
            if(units == "C") {
                if(interiorTemp >= 15) {
                    self.HVACImage?.image = #imageLiteral(resourceName: "HVAC_COOL")
                }
                else {
                    self.HVACImage?.image = #imageLiteral(resourceName: "HVAC_HEAT")
                }
            }
            else if(units == "F") {
                if(interiorTemp >= 85) {
                    self.HVACImage?.image = #imageLiteral(resourceName: "HVAC_COOL")
                }
                else {
                    self.HVACImage?.image = #imageLiteral(resourceName: "HVAC_HEAT")
                }
            }
        }
    @IBAction func DriverUp(_ sender: Any) {
        let json = CVD.Data
        if(self.DriverTempLabel.intValue >= json["response"]["climate_state"]["max_avail_temp"].intValue) {
            self.DriverTempLabel.stringValue = "\(self.DriverTempLabel.intValue)°\(units)"
        } else {
        self.DriverTempLabel.stringValue = "\(self.DriverTempLabel.intValue + 1)°\(units)"
        }
        let drvtemp = self.DriverTempLabel.integerValue
        let passtemp = self.PassengerTempLabel.integerValue
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_temps")
        let _ = Alamofire.request(url!, method: .post, parameters: ["driver_temp":drvtemp, "passenger_temp":passtemp], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
            print(response)
            
        }
    }
    @IBAction func DriverDown(_ sender: Any) {
        let json = CVD.Data
        if(self.DriverTempLabel.intValue <= json["response"]["climate_state"]["min_avail_temp"].intValue) {
            self.DriverTempLabel.stringValue = "\(self.DriverTempLabel.intValue)°\(units)"
        } else {
            self.DriverTempLabel.stringValue = "\(self.DriverTempLabel.intValue - 1)°\(units)"
        }
        let drvtemp = self.DriverTempLabel.integerValue
        let passtemp = self.PassengerTempLabel.integerValue
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_temps")
        let _ = Alamofire.request(url!, method: .post, parameters: ["driver_temp":drvtemp, "passenger_temp":passtemp], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
            print(response)
            
        }
    }
    @IBAction func PassengerUp(_ sender: Any) {
        let json = CVD.Data
        if(self.PassengerTempLabel.intValue >= json["response"]["climate_state"]["max_avail_temp"].intValue) {
            self.PassengerTempLabel.stringValue = "\(self.PassengerTempLabel.intValue)°\(units)"
        } else {
            self.PassengerTempLabel.stringValue = "\(self.PassengerTempLabel.intValue + 1)°\(units)"
        }
        let drvtemp = self.DriverTempLabel.integerValue
        let passtemp = self.PassengerTempLabel.integerValue
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_temps")
        let _ = Alamofire.request(url!, method: .post, parameters: ["driver_temp":drvtemp, "passenger_temp":passtemp], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
            print(response)
            
        }
    }
    @IBAction func PassengerDown(_ sender: Any) {
        let json = CVD.Data
        if(self.PassengerTempLabel.intValue <= json["response"]["climate_state"]["min_avail_temp"].intValue) {
            self.PassengerTempLabel.stringValue = "\(self.PassengerTempLabel.intValue)°\(units)"
        } else {
            self.PassengerTempLabel.stringValue = "\(self.PassengerTempLabel.intValue - 1)°\(units)"
        }
        let drvtemp = self.DriverTempLabel.integerValue
        let passtemp = self.PassengerTempLabel.integerValue
        let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_temps")
        let _ = Alamofire.request(url!, method: .post, parameters: ["driver_temp":drvtemp, "passenger_temp":passtemp], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
            print(response)
            
        }
    }
    
    @IBAction func HVACControl(_ sender: Any) {
        if(HVACControl.title == "Turn HVAC On") {
            HVACControl.title = "Loading"
            let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/auto_conditioning_start")
            let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
                self.HVACControl.title = "Turn HVAC Off"
            }
        } else if(HVACControl.title == "Turn HVAC Off") {
            HVACControl.title = "Loading"
            let vehicleid = CVD.vehicleIDs[CVD.SelectedVehicle]
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/auto_conditioning_stop")
            let _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: CVD.headers).responseJSON { response in
                self.HVACControl.title = "Turn HVAC On"
            }
        }

    }
    
    
    
}
