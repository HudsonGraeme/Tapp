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

import Foundation
import Cocoa
import Alamofire
import KeychainAccess

class Login: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         On Load:
         1. Contact Carspotter and compare versions
         2A. Check if there is a saved access token
            I. Load data from .Tapp file and create a new one
            II. Check if User has multiple vehicles || One vehicle and powerwall(s) || Just Powerwalls || Just Vehicles, send appropriate notification to new vc
            III. Send the user into the vehicle selection screen and use previous data
            IV. Begin background qos new data load in new vc
         2B. Check if there is a saved access token
            I. Load the view
         3.
         
         
 
        */
        
        
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let selectController = segue.destinationController as! SelectVehicle
        //YEAH
    }
    
    
}
