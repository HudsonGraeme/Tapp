//
//  Pod.swift
//  Tapp
//
//  Created by s on 2018-01-28.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa

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

    }
    override func loadView() {
        super.loadView()
        tabViewController = (parent?.children[1] as! NSTabViewController?)!
        self.view.wantsLayer = true
        //self.view.layer?.backgroundColor = NSColor.darkGray.cgColor
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        self.Tapp2.font = NSFont(name: "KaushanScript-Regular", size: 42.0)
        self.HudsonGraeme.font = NSFont(name: "KaushanScript-Regular", size: 14.0)
    }
    @IBOutlet weak var Home: NSButton!
    @IBOutlet weak var Battery: NSButton!
    @IBOutlet weak var Climate: NSButton!
    @IBOutlet weak var Location: NSButton!
    @IBOutlet weak var Info: NSButton!
    @IBOutlet weak var Settings: NSButton!
    @IBOutlet weak var Logout: NSButton!
    @IBOutlet weak var Tapp2: NSTextField!
    @IBOutlet weak var HudsonGraeme: NSTextField!
    
    var tabViewController = NSTabViewController()
    
    @IBAction func Home(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 0

    }
    @IBAction func Battery(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 1

    }
    @IBAction func Climate(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 2

    }
    @IBAction func Location(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 3

    }
    @IBAction func Info(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 4

    }
    @IBAction func Settings(_ sender: Any) {
        self.tabViewController.selectedTabViewItemIndex = 5
    }
    
    @IBAction func Logout(_ sender: Any) {
        do {
            let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
            try keychain.removeAll()
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            self.Logout.title = "Logged Out"
            self.view.window?.close()
        }
        catch {
            self.Logout.title = "Could not Logout"
        }
    }
    
}

