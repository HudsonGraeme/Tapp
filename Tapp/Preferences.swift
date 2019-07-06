//
//  Preferences.swift
//  Tapp
//
//  Created by s on 2018-02-10.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa

class Preferences: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CVD.Theme
        if(UserDefaults.standard.value(forKey: "GraphXMax") != nil) {
            switch(UserDefaults.standard.integer(forKey: "GraphXMax")) {
            case 5:
                self.GraphSaves.selectItem(at: 0)
            case 10:
                self.GraphSaves.selectItem(at: 1)
            case 25:
                self.GraphSaves.selectItem(at: 2)
            case 50:
                self.GraphSaves.selectItem(at: 3)
            default:
                print("default")
            }
        }
        if(UserDefaults.standard.integer(forKey: "LocationTimer") != 0) {
            switch(UserDefaults.standard.integer(forKey: "LocationTimer")) {
            case 5:
                self.LocationTimer.selectItem(at: 0)
            case 10:
                self.LocationTimer.selectItem(at: 1)
            case 25:
                self.LocationTimer.selectItem(at: 2)
            case 30:
                self.LocationTimer.selectItem(at: 3)
            case 60:
                self.LocationTimer.selectItem(at: 4)
            default:
                print("default")
            }
        }
        if(UserDefaults.standard.string(forKey: "Style") != "") {
            switch(UserDefaults.standard.string(forKey: "Style")!) {
            case "Light":
                self.StyleSelector.selectItem(at: 1)
            case "Dark":
                self.StyleSelector.selectItem(at: 0)
            case "Disco":
                self.StyleSelector.selectItem(at: 2)
            default:
                print("default")
            }
        }
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        NotificationCenter.default.addObserver(self, selector: #selector(self.ColorChange(_:)), name: NSNotification.Name(rawValue: "ChangeColor"), object: nil)
        if(self.view.layer?.backgroundColor == NSColor.darkGray.cgColor) {
            self.StyleSelector.selectItem(at: 0)
        } else if(self.view.layer?.backgroundColor == NSColor.lightGray.cgColor) {
            self.StyleSelector.selectItem(at: 1)
        } else {
            self.StyleSelector.selectItem(at: 2)
        }
        
    }
    @IBOutlet weak var StyleSelector: NSPopUpButton!
    @IBOutlet weak var SaveNetwork: NSButton!
    @IBOutlet weak var GraphSaves: NSPopUpButton!
    @IBOutlet weak var LocationTimer: NSPopUpButton!
    
    @objc func ColorChange(_ notification: NSNotification) {
        self.view.layer?.backgroundColor = notification.userInfo!["color"] as! CGColor
    }
    
    @IBAction func StyleSelector(_ sender: Any) {
        var color = NSColor.darkGray.cgColor
        if(StyleSelector.selectedItem?.title == "Light") {
            UserDefaults.standard.set("Light", forKey: "Style")
            CVD.Theme = NSColor.lightGray.cgColor
            color = NSColor.lightGray.cgColor
        } else if(StyleSelector.selectedItem?.title == "Dark") {
            UserDefaults.standard.set("Dark", forKey: "Style")
            CVD.Theme = NSColor.darkGray.cgColor
            color = NSColor.darkGray.cgColor
        } else if(StyleSelector.selectedItem?.title == "Disco") {
            UserDefaults.standard.set("Disco", forKey: "Style")
            CVD.Theme = NSColor.systemRed.cgColor
            color = NSColor.systemRed.cgColor
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeColor"), object: nil, userInfo: ["color":color])
    }
    @IBAction func SaveNetwork(_ sender: Any) {
        UserDefaults.standard.set(SaveNetwork.state, forKey: "SaveNetworks")
    }
    
    @IBAction func GraphSaves(_ sender: NSPopUpButton) {
        CVD.GraphSavedValues = Int(sender.selectedItem!.title)!
        UserDefaults.standard.set(Int(sender.selectedItem!.title)!, forKey: "GraphXMax")
    }
    @IBAction func LocationTimer(_ sender: Any) {
        CVD.locationTimer = LocationTimer.doubleValue
        UserDefaults.standard.set(Int(LocationTimer.selectedItem!.title)!, forKey: "LocationTimer")
    }
    
}
