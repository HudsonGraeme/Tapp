//
//  CVD.swift
//  Tapp
//
//  Created by s on 2018-02-07.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import SwiftyJSON
import Alamofire

struct CVD {
    //LOL
    let name = "Center of the Variable District"
    //END LOL
    
    //GENERAL
    static var Levels = [Int]()
    static var PowerLevels = [Int]()
    static var SavedToken = false
    static var Token: Any?
    static var numOfVehicles = 0
    static var isLoggedInWithToken = false
    static var vehicleIDs = [Int]()
    static var headers: Dictionary = [
        "Authorization": "Bearer \(Token ?? "")"
    ]
    static var EULA = false
    static var locationTimer = Double()
    static var optionCodes = [String]()
    static var SSIDs = [:] as Dictionary
    static var model = ""
    static var pass = ""
    static var VehicleTrims = [Character]()
    static var SelectedVehicle = 0
    static var Data = JSON()
    static var GraphSavedValues = 5
    //END GENERAL
    static var BatteryImage = #imageLiteral(resourceName: "FullBattery")
    static var VehicleAbov = #imageLiteral(resourceName: "compositor")
    // APPLICATION SETTINGS
    static var Theme = NSColor.darkGray.cgColor
    // END APPLICATION SETTINGS
    func Clear() {
        CVD.SavedToken = false
        CVD.Token = nil
        CVD.numOfVehicles = 0
        CVD.isLoggedInWithToken = false
        CVD.vehicleIDs.removeAll()
        CVD.headers = [
            "Authorization": "Bearer \(CVD.Token ?? "")"
        ]
        CVD.optionCodes.removeAll()
        CVD.SSIDs.removeAll()
        CVD.model = ""
        CVD.pass = ""
        CVD.VehicleTrims.removeAll()
        CVD.SelectedVehicle = 0
        CVD.BatteryImage = #imageLiteral(resourceName: "FullBattery")
    }

}






