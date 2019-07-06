//
//  Pod.swift
//  Tapp
//
//  Created by s on 2018-01-28.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import FlatButton
import KeychainAccess

class Pod: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let Size = NSSize(width: 620.0, height: 486.0)
        self.view.setFrameSize(Size)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.darkGray.cgColor
       self.tabView.tabViewType = .noTabsNoBorder
        
    }
    
}

class MenuController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Home.buttonColor = .systemGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .darkGray
        self.Logout.buttonColor = .darkGray
    }
    override func loadView() {
        super.loadView()
        tabViewController = parent?.children[1] as! NSTabViewController!
        self.view.wantsLayer = true
        //self.view.layer?.backgroundColor = NSColor.darkGray.cgColor
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        self.Tapp2.font = NSFont(name: "KaushanScript-Regular", size: 42.0)
        self.HudsonGraeme.font = NSFont(name: "KaushanScript-Regular", size: 14.0)
    }
    @IBOutlet weak var Home: FlatButton!
    @IBOutlet weak var Battery: FlatButton!
    @IBOutlet weak var Climate: FlatButton!
    @IBOutlet weak var Location: FlatButton!
    @IBOutlet weak var Info: FlatButton!
    @IBOutlet weak var Settings: FlatButton!
    @IBOutlet weak var Logout: FlatButton!
    @IBOutlet weak var Tapp2: NSTextField!
    @IBOutlet weak var HudsonGraeme: NSTextField!
    
    var tabViewController = NSTabViewController()
    
    @IBAction func Home(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 0
        self.Home.buttonColor = .systemGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .darkGray
    }
    @IBAction func Battery(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 1
        self.Home.buttonColor = .darkGray
        self.Battery.buttonColor = .systemGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .darkGray
    }
    @IBAction func Climate(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 2
        self.Home.buttonColor = .darkGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .systemGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .darkGray
    }
    @IBAction func Location(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 3
        self.Home.buttonColor = .darkGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .systemGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .darkGray
    }
    @IBAction func Info(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 4
        self.Home.buttonColor = .darkGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .systemGray
        self.Settings.buttonColor = .darkGray
    }
    @IBAction func Settings(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 5
        self.Home.buttonColor = .darkGray
        self.Battery.buttonColor = .darkGray
        self.Climate.buttonColor = .darkGray
        self.Location.buttonColor = .darkGray
        self.Info.buttonColor = .darkGray
        self.Settings.buttonColor = .systemGray
    }
    
    @IBAction func Logout(_ sender: Any) {
        do {
            let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
            try keychain.removeAll()
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            self.Logout.buttonColor = .systemGray
            self.Logout.title = "Logged Out"
            self.view.window?.close()
        }
        catch {
            self.Logout.title = "Could not Logout"
        }
    }
    
}

