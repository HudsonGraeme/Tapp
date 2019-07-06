//
//  login.swift
//  Tapp
//
//  Created by Hudson Graeme on 2017-01-07.
//  Open Source
//

import Foundation
import Cocoa
import Alamofire
import SwiftyJSON
import AlamofireImage
//import ObjectMapper
import WebKit
import SwiftWebSocket
import Charts
import Locksmith

class login: NSViewController, NSTextFieldDelegate /*ChartViewDelegate*/{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Graph.noDataText = "Please Wait"
        self.outD.noDataText = "Please"
        self.inD.noDataText = "Wait"

}
    
    

    @IBOutlet weak var batLvl: NSTextField! // Battery level textbox
    @IBOutlet weak var stndrd: NSButton! //Set charge level to 100%
    @IBOutlet weak var trip: NSButton! //Set charge level to 90%
    @IBOutlet weak var stp: NSButton! //Stop the custom alarm
    @IBOutlet weak var Emerg: NSButton! //Custom alarm button
    @IBOutlet weak var stCharg: NSButton! //Stop Charge
    @IBOutlet weak var sCharg: NSButton! //Start Charging
    @IBOutlet weak var openPort: NSButton! //Open Charge port
    @IBOutlet weak var valetPIN: NSSecureTextField! //Valet PIN field
    @IBOutlet weak var valetOnOff: NSSegmentedControl! //Valet mode on or off
    @IBOutlet weak var valetRpin: NSButton! //Reset Valet PIN
    @IBOutlet weak var logOut: NSButton! //Logout button
    @IBOutlet weak var Graph: BarChartView! //Battery graph
    @IBOutlet weak var gMap: WebView! //The map webView
    @IBOutlet weak var rData: NSButton! //Refresh for location and other data
    @IBOutlet weak var curl: NSTextField! //dummy textfield
    @IBOutlet weak var lat: NSTextField! //Datafield
    @IBOutlet weak var streamid: NSTextField! //dummy textfield
    @IBOutlet weak var carType: NSTextField! //dummy textfield
    @IBOutlet weak var imgtext: NSTextField! //dummy textfield
    @IBOutlet weak var vehimg: NSImageView! //vehicle image
    @IBOutlet weak var vehName: NSTextField! //Name & error textfield
    @IBOutlet weak var cView: NSButton! //Change View button
    @IBOutlet weak var lock: NSButton! //lock
    @IBOutlet weak var unlock: NSButton! //unlock
    @IBOutlet weak var horn: NSButton! //Horn button
    @IBOutlet weak var flash: NSButton! //Flash Lights button
    @IBOutlet weak var pano: NSButton! //Roof button
    @IBOutlet weak var tempSet: NSButton! //Set Temp and Start Climate button
    @IBOutlet weak var tempOff: NSButton! //Stop Climate button
    @IBOutlet weak var rStart: NSButton! //Remote start button
    @IBOutlet weak var tokenn: NSTextField! //dummy textfield
    @IBOutlet weak var vehicleidd: NSTextField! //dummy textfield
    @IBOutlet weak var modelimg: NSImageView! //image for model: for example 85D
    @IBOutlet weak var outD: BarChartView! //outside degrees chart
    @IBOutlet weak var inD: BarChartView! //inside degrees chart
    @IBOutlet weak var vehModd: NSTextField!
    @IBOutlet weak var batSet: NSSlider! //Charge level slider
    @IBOutlet weak var batSettext: NSTextField! //Dummy field?
    @IBOutlet weak var alat: NSTextField! // Dummy field
    @IBOutlet weak var long: NSTextField! // Dummy field
    
    
    
    
    func getnewimg() {
        let curr = self.curl.stringValue
        let array = ["3QTR", "ABOV", "SIDE", "REAR", "SEAT_ALTA"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        let rdm = array[randomIndex]
        let options = self.imgtext.stringValue
        let model = self.carType.stringValue
        let url = URL(string:"https://www.tesla.com/configurator/compositor/?model=\(model)&view=STUD_\(rdm)&size=500&options=\(options)")
        let ncurr = url?.absoluteString
        self.curl.stringValue = ncurr!
        let request = Alamofire.request(url!).responseImage { response in
            let data = response.result.value
            self.vehimg.image = data
        }
    }
    
    
    
    func getmodel() {
        let model = self.vehModd.stringValue
        let url = URL(string:"https://www.tesla.com/sites/all/modules/custom/tesla_configurator/images/web/battery/ui_option_battery_\(model)@2x.png")
        print(url)
        let request = Alamofire.request(url!).responseImage { response in
            let data = response.result.value
            self.modelimg.isEnabled = true
            self.modelimg.image = data
        }
        
        
    }
    
                func getCharge() {
                    let token = self.tokenn.stringValue
                    let vehicleid = self.vehicleidd.stringValue
                        let headers = [
                            "Authorization": "Bearer \(token)"
                        ]
                        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/charge_state")
                        
                        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                            }
                            .validate { request, response, data in
                                
                                return .success
                            }
                            .responseJSON { response in
                                
                                switch response.result {
                                    
                                case .success:
                                    print("getCharge response: \(response)")
                                    
                                    
                                    let data = response.result.value
                                    
                                        let json = JSON(data!)["response"]
                                    
                                        let chargestate = json["charging_state"]
                                        let vehMod = json["charge_limit_soc"]
                                    self.batSet.doubleValue = vehMod.doubleValue
                                        if(chargestate == "Charging") {
                                            self.openPort.isEnabled = false
                                            self.stCharg.isEnabled = true
                                            self.sCharg.isEnabled = false
                                        let bCurrent = json["battery_current"]
                                        let hOn = json["battery_heater_on"]
                                        let lev = json["usable_battery_level"].doubleValue
                                        let range = json["battery_range"].doubleValue
                                        let rCurrent = json["charge_current_request"]
                                        let rCurrentMax = json["charge_current_request_max"]
                                        let cEnableReq = json["charge_enable_request"]
                                        let enAdded = json["charge_energy_added"]
                                        let dOpen = json["charge_port_door_open"]
                                        let cColour = json["charge_port_led_color"] //proper spelling
                                            let Erange = json["est_battery_range"].doubleValue
                                        print("Charge State: ", chargestate, "\r\n", "Battery Current ", bCurrent, "\r\n", "Battery Heater is ", hOn, "\r\n","Battery Percent ", lev, "\r\n", "Rated Range ", range * 1.6, "\r\n", "Requested Current", rCurrent, "\r\n", "Max Current", rCurrentMax, "\r\n", "Enable request? ", cEnableReq, "\r\n", "Energy Added ", enAdded, "\r\n", "Charge limit ", vehMod, "\r\n", "Charge Port Door ", dOpen, "\r\n", "Charge Port Colour", cColour, "\r\n", "Estimated Range ", Erange * 1.6)
                                            
                                            
                                    
                                            
                                            /*let ds = LineChartDataSet(values: lev, label: "")
                                            if(lev <= 25) {
                                                ds.colors = [NSUIColor.red]
                                            }
                                            else if(lev <= 60) {
                                                ds.colors = [NSUIColor.orange]
                                            }
                                            else {
                                                ds.colors = [NSUIColor.green]
                                            }
                                            */
                                            
                                            let charg = Array(1..<2).map { x in return lev }
                                            
                                            let charge = charg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                                            
                                            let data = BarChartData()
                                            let ds1 = BarChartDataSet(values: charge, label: "")
                                            if(lev <= 25) {
                                                ds1.colors = [NSUIColor.red]
                                            }
                                            else if(lev <= 60) {
                                            ds1.colors = [NSUIColor.orange]
                                            }
                                            else {
                                            ds1.colors = [NSUIColor.green]
                                            }
                                            data.addDataSet(ds1)
                                            self.Graph.scaleYEnabled = false
                                            self.Graph.leftAxis.axisMaximum = 100
                                            self.Graph.rightAxis.axisMaximum = 100
                                            self.Graph.leftAxis.axisMinimum = 0
                                            self.Graph.rightAxis.axisMinimum = 0
                                            self.Graph.data = data
                                            self.Graph.gridBackgroundColor = NSUIColor.darkGray
                                            self.Graph.chartDescription?.text = ""
                                            self.Graph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
 
                                        
                                    }
                                        else {
                                            self.openPort.isEnabled = true
                                            let lev = json["usable_battery_level"].doubleValue
                                            if(lev == 99) {
                                                let lev = 100
                                            }
                                            
                                            let charg = Array(1..<2).map { x in return lev }
                                            
                                            let charge = charg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                                            
                                            let data = BarChartData()
                                            let ds1 = BarChartDataSet(values: charge, label: "")
                                            if(lev <= 25) {
                                                ds1.colors = [NSUIColor.red]
                                            }
                                            else if(lev <= 60) {
                                                ds1.colors = [NSUIColor.orange]
                                            }
                                            else {
                                                ds1.colors = [NSUIColor.green]
                                            }

                                            data.addDataSet(ds1)
                                            self.Graph.rightAxis.enabled = false
                                            self.Graph.leftAxis.axisMaximum = 100
                                            self.Graph.leftAxis.axisMinimum = 0
                                            self.Graph.data = data
                                            self.Graph.gridBackgroundColor = NSUIColor.darkGray
                                            self.Graph.chartDescription?.text = ""
                                            self.Graph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
 
                                    }
                                    self.getmodel()
                                default:
                                    print("getCharge defaulted")
                                }
                                
                                
                                
                        }
                     
                        loc()
    
            }
    
    func getcardata(){ //Moving all of the other funcs here.
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data")
        let request = Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
            progress in
        }
            .validate { request, response, data in
                return .success
                
        }
            .responseJSON {
                response in
                let data = response.result.value
                let json = JSON(data)["response"]
                print("getcardata Response ", json)
                let vehMod = json["vehicle_config"]["trim_badging"].stringValue
                self.vehModd.stringValue = vehMod
                if(json["vehicle_state"]["valet_mode"] == "true") {
                    self.valetOnOff.selectedSegment = 0
                }
                else if(json["vehicle_state"]["valet_mode"] == "false") {
                    self.valetOnOff.selectedSegment = 1
                }
                let isLocked = json["vehicle_state"]["locked"]
                if(isLocked == "1"||isLocked == "true") {
                    self.lock.isEnabled = false
                    
                }
                else {
                    self.unlock.isEnabled = false
                }
                
                
                
                
             self.getCharge()
        }
    }
                    func getClimate() {
                       
                        let token = self.tokenn.stringValue
                        let vehicleid = self.vehicleidd.stringValue
                        let headers = [
                            "Authorization": "Bearer \(token)"
                        ]
                        
                        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/climate_state")
                        
                        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                            }
                            .validate { request, response, data in
                                
                                return .success
                            }
                            .responseJSON { response in
                          
                                switch response.result {
                                    
                                case .success:
                                    print("getClimate response: \(response)")
                                    
                                    
                                    let data = response.result.value
                                    if data != nil {
                                    
                                        let json = JSON(data!)["response"]
]                                       let inTemp = json["inside_temp"]
                                        let outTemp = json["outside_temp"]
                                        let aOn = json["is_climate_on"]
                                        let FRon = json["seat_heater_right"]
                                        let FLon = json["seat_heater_left"]
                                        let RLon = json["seat_heater_rear_left"]
                                        let RCon = json["seat_heater_rear_center"]
                                        let RRon = json["seat_heater_rear_right"]
                                        
                                        if(aOn == "true"||aOn == "1") {
                                            self.tempSet.isEnabled = false
                                        }
                                        else {
                                            self.tempOff.isEnabled = false
                                        }
                                        let inDeg = inTemp.doubleValue
                                        let deg = Array(1..<2).map { x in return inDeg }
                                        
                                        let degc = deg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                                        
                                        let data = BarChartData()
                                        let ds1 = BarChartDataSet(values: degc, label: "")
                                        if(inDeg >= 20) {
                                            ds1.colors = [NSUIColor.orange]
                                        }
                                        else if(inDeg >= 30) {
                                            ds1.colors = [NSUIColor.red]
                                        }
                                        else if(inDeg <= 5) {
                                            ds1.colors = [NSUIColor.blue]
                                        }
                                        else {
                                            ds1.colors = [NSUIColor.green]
                                        }
                                        
                                        data.addDataSet(ds1)
                                        //self.inD.scaleYEnabled = false
                                        self.inD.rightAxis.drawLabelsEnabled = false
                                        self.inD.leftAxis.axisMaximum = 40
                                        self.inD.leftAxis.axisMinimum = -30
                                        self.inD.data = data
                                        self.inD.gridBackgroundColor = NSUIColor.darkGray
                                        self.inD.chartDescription?.text = ""
                                        self.inD.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
                                    
                                        
                                    
                                        let outDeg = outTemp.doubleValue
                                        let deg1 = Array(1..<2).map { x in return outDeg }
                                        
                                        let degc1 = deg1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                                        
                                        let data1 = BarChartData()
                                        let ds2 = BarChartDataSet(values: degc1, label: "")
                                        if(outDeg >= 20) {
                                            ds2.colors = [NSUIColor.orange]
                                        }
                                        else if(outDeg >= 30) {
                                            ds2.colors = [NSUIColor.red]
                                        }
                                        else if(outDeg <= 5) {
                                            ds2.colors = [NSUIColor.blue]
                                        }
                                        else if(outDeg >= 5 && outDeg <= 20){
                                            ds2.colors = [NSUIColor.green]
                                        }
                                        
                                        data1.addDataSet(ds2)
                                        self.outD.rightAxis.drawLabelsEnabled = false
                                        self.outD.leftAxis.axisMaximum = 40
                                        self.outD.leftAxis.axisMinimum = -30
                                        self.outD.data = data1
                                        self.outD.gridBackgroundColor = NSUIColor.darkGray
                                        self.outD.chartDescription?.text = ""
                                        self.outD.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
 
                                    
                                }
                                    self.getcardata()
                                default:
                                    print("data_request defaulted")
                                }
                       }
            }
    
    

    func getimg() {
        let options = self.imgtext.stringValue
        let model = self.carType.stringValue
        let url = URL(string:"https://www.tesla.com/configurator/compositor/?model=m\(model)&view=STUD_ABOV&size=500&options=\(options)")
        let curr = url?.absoluteString
        self.curl.stringValue = curr!
        let request = Alamofire.request(url!).responseImage { response in
            let data = response.result.value
            self.vehimg.image = data
            self.cView.isEnabled = true
            self.getClimate()
        }
    }

    
    

    func getdata(){
        
        
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/vehicle_state")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    let data = response.result.value
                    if data != nil {
                        
                        let json = JSON(data!)["response"]
                        self.carType.stringValue = json[]["car_type"].stringValue
                        if(json["sun_roof_installed"].stringValue == "1") {
                            self.pano.isEnabled = true
                        }
                        else {
                            self.pano.isEnabled = false
                        }
                        self.getimg()
                    }
                default:
                    print("data_request defaulted")
                }
        }
    }

    
    

        func mobileacc() {
            let token = self.tokenn.stringValue
            let vehicleid = self.vehicleidd.stringValue
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/mobile_enabled")

            let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                }
                .validate { request, response, data in
                    
                    return .success
                }
                .responseJSON { response in
                    
                    switch response.result {
                        
                    case .success:
                        let data = response.result.value
                        let json = JSON(data!)["response"]
                        print("mobileacc", json)
                        if(json.stringValue == "true") {
                            self.degrees.isEnabled = true
                            self.vehName.isEnabled = true
                            self.vehName.textColor = NSColor.gray
                            self.lock.isEnabled = true
                            self.unlock.isEnabled = true
                            self.horn.isEnabled = true
                            self.flash.isEnabled = true
                            self.tempSet.isEnabled = true
                            self.tempOff.isEnabled = true
                            self.rData.isEnabled = true

                            
                        } else
                        {
                            print("response isn't true")
                            self.vehName.isEnabled = false
                            self.vehName.textColor = NSColor.red
                            self.vehName.stringValue = "Mobile access is disabled!"
                            self.lock.isEnabled = false
                            self.unlock.isEnabled = false
                            self.horn.isEnabled = false
                            self.flash.isEnabled = false
                            self.tempSet.isEnabled = false
                            self.tempOff.isEnabled = false
                            self.degrees.isEnabled = false
                            self.pano.isEnabled = false
                            self.rStart.isEnabled = false
                        }
                        self.getdata()
                    default:
                        print("everything isn't fine")
                    }
            }
    }
    
    
    
    func getvehicle() {
        let token = self.tokenn.stringValue
        
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                
                
                switch response.result {
                    
                case .success:
                    
                    let data = response.result.value
                    if data != nil {
                        let json = JSON(data!)["response"]
                        print(json)
                        
                        self.vehicleidd.stringValue = json[0]["id"].stringValue
                        self.streamid.stringValue = json[0]["vehicle_id"].stringValue
                        self.vehName.textColor = NSColor.darkGray
                        self.vehName.stringValue = json[0]["display_name"].stringValue
                        self.imgtext.stringValue = json[0]["option_codes"].stringValue
                        if json[0]["remote_start_enabled"].stringValue == "true" {
                            self.rStart.isEnabled = true
                        }
                        else {
                            self.rStart.isEnabled = false
                        }
                        let vehiclecount = json["count"]
                        self.mobileacc()
                    }
                default:
                    
                    print("vehicles defaulted")
                }
        }
        
    }

    
    func gc1() {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/charge_state")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    print("getCharge response: \(response)")
                    
                    
                    let data = response.result.value
                    
                    let json = JSON(data!)["response"]
                    
                    let chargestate = json["charging_state"]
                    let vehMod = json["charge_limit_soc"]
                    self.batSet.doubleValue = vehMod.doubleValue
                    self.batLvl.stringValue = "\(vehMod.doubleValue)%"
                    if(chargestate == "Charging") {
                        self.openPort.isEnabled = false
                        self.stCharg.isEnabled = true
                        self.sCharg.isEnabled = false
                        let bCurrent = json["battery_current"]
                        let hOn = json["battery_heater_on"]
                        let lev = json["usable_battery_level"].doubleValue
                        let range = json["battery_range"].doubleValue
                        let rCurrent = json["charge_current_request"]
                        let rCurrentMax = json["charge_current_request_max"]
                        let cEnableReq = json["charge_enable_request"]
                        let enAdded = json["charge_energy_added"]
                        let dOpen = json["charge_port_door_open"]
                        let cColour = json["charge_port_led_color"] //proper spelling
                        let Erange = json["est_battery_range"].doubleValue
                        print("Charge State: ", chargestate, "\r\n", "Battery Current ", bCurrent, "\r\n", "Battery Heater is ", hOn, "\r\n","Battery Percent ", lev, "\r\n", "Rated Range ", range * 1.6, "\r\n", "Requested Current", rCurrent, "\r\n", "Max Current", rCurrentMax, "\r\n", "Enable request? ", cEnableReq, "\r\n", "Energy Added ", enAdded, "\r\n", "Charge limit ", vehMod, "\r\n", "Charge Port Door ", dOpen, "\r\n", "Charge Port Colour", cColour, "\r\n", "Estimated Range ", Erange * 1.6)
                        
                        
                        
                        
                        /*let ds = LineChartDataSet(values: Double(lev), label: "")
                         if(lev <= 25) {
                         ds.colors = [NSUIColor.red]
                         }
                         else if(lev <= 60) {
                         ds.colors = [NSUIColor.orange]
                         }
                         else {
                         ds.colors = [NSUIColor.green]
                         }
                        */
                        
                       let charg = Array(1..<2).map { x in return lev }
                        
                        let charge = charg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                        
                        let data = BarChartData()
                        let ds1 = BarChartDataSet(values: charge, label: "")
                        if(lev <= 25) {
                            ds1.colors = [NSUIColor.red]
                        }
                        else if(lev <= 60) {
                            ds1.colors = [NSUIColor.orange]
                        }
                        else {
                            ds1.colors = [NSUIColor.green]
                        }
                        data.addDataSet(ds1)
                        self.Graph.scaleYEnabled = false
                        self.Graph.leftAxis.axisMaximum = 100
                        self.Graph.rightAxis.axisMaximum = 100
                        self.Graph.leftAxis.axisMinimum = 0
                        self.Graph.rightAxis.axisMinimum = 0
                        self.Graph.data = data
                        self.Graph.gridBackgroundColor = NSUIColor.darkGray
                        self.Graph.chartDescription?.text = ""
                        self.Graph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
                        
                    }
                    else {
                        
                        self.openPort.isEnabled = true
                        let lev = json["usable_battery_level"].doubleValue
                        var arr: Array = [] as Array
                        arr += [lev]
                        let defaults = UserDefaults.standard
                        defaults.set(arr, forKey: "chgar")
                        print(defaults.value(forKey: "chgar"))
                        if(lev == 99) {
                            let lev = 100
                        }
                        
                        let charg = Array(1..<2).map { x in return lev }
                        
                        let charge = charg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                        
                        let data = BarChartData()
                        let ds1 = BarChartDataSet(values: charge, label: "")
                        if(lev <= 25) {
                            ds1.colors = [NSUIColor.red]
                        }
                        else if(lev <= 60) {
                            ds1.colors = [NSUIColor.orange]
                        }
                        else {
                            ds1.colors = [NSUIColor.green]
                        }
                        
                        data.addDataSet(ds1)
                        self.Graph.rightAxis.enabled = false
                        self.Graph.leftAxis.axisMaximum = 100
                        self.Graph.leftAxis.axisMinimum = 0
                        self.Graph.data = data
                        self.Graph.gridBackgroundColor = NSUIColor.darkGray
                        self.Graph.chartDescription?.text = ""
                        self.Graph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
 
                    }
                    self.getmodel()
                default:
                    print("getCharge defaulted")
                }
                
        }
        
        }
        

    func gc() {
        
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/climate_state")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    print("gc response: \(response)")
                    
                    
                    let data = response.result.value
                    if data != nil {
                        
                        let json = JSON(data!)["response"]
                        let inTemp = json["inside_temp"]
                        let outTemp = json["outside_temp"]
                        let aOn = json["is_climate_on"]
                        let FRon = json["seat_heater_right"]
                        let FLon = json["seat_heater_left"]
                        let RLon = json["seat_heater_rear_left"]
                        let RCon = json["seat_heater_rear_center"]
                        let RRon = json["seat_heater_rear_right"]
                        
                        
                        let inDeg = inTemp.doubleValue
                        let deg = Array(1..<2).map { x in return inDeg }
                        
                        let degc = deg.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                        
                        let data = BarChartData()
                        let ds1 = BarChartDataSet(values: degc, label: "")
                        if(inDeg >= 20) {
                            ds1.colors = [NSUIColor.orange]
                        }
                        else if(inDeg >= 30) {
                            ds1.colors = [NSUIColor.red]
                        }
                        else if(inDeg <= 5) {
                            ds1.colors = [NSUIColor.blue]
                        }
                        else {
                            ds1.colors = [NSUIColor.green]
                        }
                        
                        data.addDataSet(ds1)
                        //self.inD.scaleYEnabled = false
                        self.inD.rightAxis.drawLabelsEnabled = false
                        self.inD.leftAxis.axisMaximum = 40
                        self.inD.leftAxis.axisMinimum = -30
                        self.inD.data = data
                        self.inD.gridBackgroundColor = NSUIColor.darkGray
                        self.inD.chartDescription?.text = ""
                        self.inD.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
                        
                        
                        
                        let outDeg = outTemp.doubleValue
                        let deg1 = Array(1..<2).map { x in return outDeg }
                        
                        let degc1 = deg1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
                        
                        let data1 = BarChartData()
                        let ds2 = BarChartDataSet(values: degc1, label: "")
                        if(outDeg >= 20) {
                            ds2.colors = [NSUIColor.orange]
                        }
                        else if(outDeg >= 30) {
                            ds2.colors = [NSUIColor.red]
                        }
                        else if(outDeg <= 5) {
                            ds2.colors = [NSUIColor.blue]
                        }
                        else if(outDeg >= 5 && outDeg <= 20){
                            ds2.colors = [NSUIColor.green]
                        }
                        
                        data1.addDataSet(ds2)
                        self.outD.rightAxis.drawLabelsEnabled = false
                        self.outD.leftAxis.axisMaximum = 40
                        self.outD.leftAxis.axisMinimum = -30
                        self.outD.data = data1
                        self.outD.gridBackgroundColor = NSUIColor.darkGray
                        self.outD.chartDescription?.text = ""
                        self.outD.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
                        
                    }
                    self.gc1()
                default:
                    print("data_request defaulted")
                }
        }
    }
    
    func loc() {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data_request/drive_state")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in
                let data = response.result.value
                let json = JSON(data!)["response"]
                print(json)
                if(json["error"] == "vehicle unavailible") {
                    print(json["error"])
                    self.wakeup()
                }

                let lati = json["latitude"]
                let longi = json["longitude"]
                print(lati, longi)
                let head = json["heading"]
                let shift = json["shift_state"].stringValue
                let speed = json["speed"].doubleValue
                if(shift == "") {
                    self.Emerg.isEnabled = true
                }
                self.gMap.mainFrameURL = "https://www.google.ca/maps/place/\(lati.stringValue),\(longi.stringValue)/data=!3m1!1e3"

                print(self.gMap.mainFrameURL)
                if(shift == "") {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | State: Off | Heading: \(head)"
                    //print("Off: ", self.lat.stringValue)
                }
                else if(shift == "D") {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | Gear: Drive | Speed: \(speed)mi/h (\(speed * 1.6)km/h) | Heading: \(head)"
                    //print("D:  ", self.lat.stringValue)
                }
                else if(shift == "P") {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | Gear: Park | Heading: \(head)"
                    //print("Park:  ", self.lat.stringValue)
                }
                else if(shift == "R") {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | Gear: Reverse | Speed: \(speed)mi/h (\(speed * 1.6)km/h) | Heading: \(head)"
                    //print("R:  ", self.lat.stringValue)
                }
                else if(shift == "N") {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | Gear: Neutral | Speed: \(speed)mi/h (\(speed * 1.6)km/h) | Heading: \(head)"
                    //print("N:  ", self.lat.stringValue)
                }
                else {
                    self.lat.stringValue = "Latitude: \(lati) | Longitude: \(longi) | State: Off | Heading: \(head) *ERROR* Please Contact Dev"
                    //print("else:  ", self.lat.stringValue)
                }
                //print(lati, longi, shift, speed, head)
                var grabdata = Timer.scheduledTimer(timeInterval: TimeInterval(60), target: self, selector: Selector("loc"), userInfo: nil, repeats: true)
                var grabdata1 = Timer.scheduledTimer(timeInterval: TimeInterval(60), target: self, selector: Selector("gc"), userInfo: nil, repeats: true)

            }
            
    }

    func wakeup() {
            let token = self.tokenn.stringValue
            let vehicleid = self.vehicleidd.stringValue
            let headers = [
                "Authorization": "Bearer \(token)"
            ]

            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/wake_up")
            
            let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                let data = response.result.value
        }
    }
        @IBAction func rData(_ sender: Any) {
        loc()
        gc()
    }


    @IBAction func lock(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/door_lock")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            
        }
        self.lock.isEnabled = false
        self.unlock.isEnabled = true
    }
    @IBAction func unlock(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/door_unlock")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
        }
        self.lock.isEnabled = true
        self.unlock.isEnabled = false
    }
    
    @IBAction func horn(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/honk_horn")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
        }
    }
    @IBAction func flash(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/flash_lights")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            print(response.response?.statusCode)
        
            
        }

    }
    
    
    @IBAction func pano(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/trunk_open?which_trunk=rear")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            }
            .validate { request, response, data in
                
                return .success
            }
            .responseJSON { response in

        
        }

           }
    
    @IBOutlet weak var degrees: NSTextField!
    @IBAction func tempSet(_ sender: Any) {
        let degreesc = degrees.doubleValue
        if(degreesc >= 28) {
            let degreesc = 28
            self.degrees.doubleValue = 28
        }
        else if(degreesc <= 15) {
            self.degrees.doubleValue = 15
            let degreesc = 15
        }
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_temps?driver_temp=\(degreesc)&passenger_temp=\(degreesc)")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let token = self.tokenn.stringValue
            let vehicleid = self.vehicleidd.stringValue
            let headers = [
                "Authorization": "Bearer \(token)"
            ]
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/auto_conditioning_start")
            
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            }
            self.tempSet.isEnabled = false
            self.tempOff.isEnabled = true
        }
        
    }
    
    @IBAction func tempOff(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]

        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/auto_conditioning_stop")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            self.tempOff.isEnabled = false
            self.tempSet.isEnabled = true
    }
    }
    
    @IBAction func rStart(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/remote_start_drive?password=") //PASS HERE
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            
        }
    }

    
    @IBAction func cView(_ sender: Any) {
        getnewimg()
    }
    

    
    func getData() {
        let vehid = self.vehicleidd.stringValue
        let token = self.tokenn.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehid)/data")
        
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                
                
                switch response.result {
                    
                case .success:
                    let data = response.result.value
                    let json = JSON(data!)
                    
                    print(data)
                default:
                    
                    print("data defaulted")
                }
        }
        
    }
    @IBAction func batSet(_ sender: NSSlider) {
        self.batLvl.stringValue = "\(sender.integerValue)%"
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        print(sender.integerValue)
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_charge_limit?percent=\(sender.integerValue)")!
        print(url)
        let request = Alamofire.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let data = response.result.value
            let json = JSON(data!)
            self.gc1()
        }
    }


    
    @IBAction func modelimgHeld(_ sender: Any) {
        self.modelimg.isEnabled = true
        self.modelimg.image = #imageLiteral(resourceName: "ludicrous")
        self.modelimg.rotate(byDegrees: CGFloat(Float.pi))
    }
    
    
    @IBAction func valetOnOff(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        if(self.valetOnOff.selectedSegment == 0) {
            if(self.valetPIN.stringValue != "") {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_valet_mode?on=true&password=\(self.valetPIN.stringValue)")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            self.valetOnOff.selectedSegment = 0
        }
            }
            else {
                self.valetPIN.placeholderString = "Enter PIN"
            }
        }
        else if(self.valetOnOff.selectedSegment == 1) {
            if(self.valetPIN.stringValue != "") {
            let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/set_valet_mode?on=false&password=\(self.valetPIN.stringValue)")
            
            let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                self.valetOnOff.selectedSegment = 1
                let data = response.result.value
                let json = JSON(data!)
                print(json)
            }
            }
            else {
                self.valetPIN.placeholderString = "Enter PIN"
            }
        }
        
    }

    @IBAction func valetRpin(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/reset_valet_pin")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let data = response.result.value
            let json = JSON(data!)
            print(json)
        }

    }
    
    @IBAction func openPort(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/charge_port_door_open")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        }
        

    }
    
    @IBAction func sCharg(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/charge_start")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        }
        self.sCharg.isEnabled = false
        self.stCharg.isEnabled = true
        

    }
 
    @IBAction func stCharg(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/charge_stop")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        }
        
        self.sCharg.isEnabled = true
        self.stCharg.isEnabled = false

    }
    var time = Timer()

    
    @IBAction func Emerg(_ sender: Any) {
        time = Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: Selector("alm"), userInfo: nil, repeats: true)
        self.stp.isEnabled = true
    }
    
    @IBAction func stp(_ sender: Any) {
        time.invalidate()
        self.Emerg.isEnabled = true
    }
    
    func alm() {
        self.Emerg.isEnabled = false
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/flash_lights")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            print(response.response?.statusCode)
            
        }
        let token1 = self.tokenn.stringValue
        let vehicleid1 = self.vehicleidd.stringValue
        let headers1 = [
            "Authorization": "Bearer \(token1)"
        ]
        let url1 = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid1)/command/honk_horn")
        
        let request1 = Alamofire.request(url1!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers1).responseJSON { response in
            
        }
        
        
    }
    
    
    @IBAction func stndrd(_ sender: Any) {
        let token = Locksmith.loadDataForUserAccount(userAccount: "user")
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/charge_standard")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            print(response.response?.statusCode)
            self.gc1()
        }
        
    }
    @IBAction func trip(_ sender: Any) {
        let token = self.tokenn.stringValue
        let vehicleid = self.vehicleidd.stringValue
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/command/charge_max_range")
        
        let request = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            print(response.response?.statusCode)
            self.gc1()
        }
        
    }
    

    
    
    
    
    @IBAction func logOut(_ sender: Any) {
        do {
        try Locksmith.deleteDataForUserAccount(userAccount: "user")
        }
        catch {
            print("Logout failed")
        }
        self.degrees.isEnabled = false
        self.vehName.isEnabled = false
        self.lock.isEnabled = false
        self.unlock.isEnabled = false
        self.horn.isEnabled = false
        self.flash.isEnabled = false
        self.tempSet.isEnabled = false
        self.tempOff.isEnabled = false
        self.rData.isEnabled = false
        self.logOut.isHidden = true
        self.gMap.mainFrameURL = ""
        self.vehimg.image = nil
        self.cView.isEnabled = false
        self.modelimg.image = nil
        self.outD.clear()
        self.inD.clear()
        self.batSet.doubleValue = 0
        self.Graph.clear()
        self.pano.isEnabled = false
        self.rStart.isEnabled = false
        self.vehName.stringValue = ""
        self.tokenn.stringValue = ""
        self.alat.stringValue = ""
        self.curl.stringValue = ""
        self.carType.stringValue = ""
        self.degrees.stringValue = ""
        self.imgtext.stringValue = ""
        self.vehModd.stringValue = ""
        self.vehicleidd.stringValue = ""
        self.lat.stringValue = ""
        self.valetOnOff.isEnabled = false
        self.valetPIN.isEnabled = false
        self.valetRpin.isEnabled = false
        self.openPort.isEnabled = false
        self.sCharg.isEnabled = false
        self.stCharg.isEnabled = false
        self.trip.isEnabled = false
        self.stndrd.isEnabled = false
        self.Emerg.isEnabled = false
        self.stp.isEnabled = false
        self.time.invalidate()
        self.modelimg.isHidden = true
        self.modelimg.isEnabled = true
    }

}


