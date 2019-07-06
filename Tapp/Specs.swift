//
//  Specs.swift
//  Tapp
//
//  Created by s on 2018-02-12.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import SwiftyJSON

class Specs: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        DisplayData(forVehicle: CVD.SelectedVehicle)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CVD.Theme
    }
    
    
    @IBOutlet var Lb1: NSTextView!
    
    @objc func DisplayData(forVehicle vehicle:Int) {
        let json = CVD.Data[CVD.SelectedVehicle]["response"]
        var Str = String(describing: json.dictionary!)
        Str = Str.replacingOccurrences(of: "{", with: "")
        Str = Str.replacingOccurrences(of: "}", with: "")
        Str = Str.replacingOccurrences(of: "[", with: "")
        Str = Str.replacingOccurrences(of: "]", with: "")
        Str = Str.replacingOccurrences(of: "\"", with: "")
        //Str = Str.replacingOccurrences(of: "\r", with: "")
        //Str = Str.replacingOccurrences(of: "\n", with: "")
        let MutStr = NSMutableAttributedString(string: Str)
        let alphabet: [String] = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "/", ".", "_", ":", ","
        ]
        
        for i in 0...(alphabet.count - 1) {
            MutStr.setColorForText(attrStr: MutStr, alphabet[i], with: .white)
        }
        for (key, value) in json.dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["charge_state"].dictionaryValue {
            
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["drive_state"].dictionaryValue {
            
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["climate_state"].dictionaryValue {
            
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["gui_settings"].dictionaryValue {
            
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["vehicle_config"].dictionaryValue {
            
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        for (key, value) in json["vehicle_state"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, String(describing: value), with: .white)
        }
        MutStr.setColorForText(attrStr: MutStr, ".", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "0", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "1", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "2", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "3", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "4", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "5", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "6", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "7", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "8", with: .yellow)
        MutStr.setColorForText(attrStr: MutStr, "9", with: .yellow)
        for (key, value) in json.dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["charge_state"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["drive_state"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["climate_state"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["gui_settings"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["vehicle_config"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["vehicle_state"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .systemBlue)
        }
        for (key, value) in json["tokens"].dictionaryValue {
            MutStr.setColorForText(attrStr: MutStr, key, with: .white)
        }
        
            MutStr.setColorForText(attrStr: MutStr, json["vin"].stringValue, with: .white)
        
        MutStr.setColorForText(attrStr: MutStr, "true", with: .green)
        MutStr.setColorForText(attrStr: MutStr, "false", with: .red)
        MutStr.setColorForText(attrStr: MutStr, "null", with: .lightGray)
        
        self.Lb1.textStorage?.setAttributedString(MutStr)
    }
    
    
    func translator(fromTesla input:String) -> String {
        var output = String()
        switch(input) {
        case "id":
            output = "Vehicle ID"
        case "state":
            output = "Vehicle State"
        case "remote_start_enabled":
            output = "Remote Start Enabled"
        case "in_service":
            output = "Vehicle in for service"
        case "vin":
            output = "VIN"
        case "display_name":
            output = "Vehicle Name"
        case "notifications_enabled":
            output = "Notifications"
        default:
            output = "Vehicle \(input)"
        }
        return output
    }

}
