//
//  About.swift
//  Tapp
//
//  Created by s on 2018-02-08.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa

class About: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CVD.Theme
    }
    @IBOutlet weak var PayPal: NSButton!
    @IBOutlet weak var Patreon: NSButton!
    @IBOutlet weak var Txt: NSScrollView!
    
    @IBAction func PayPal(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.paypal.me/SpencerGraham")!)
    }
    @IBAction func Patreon(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.patreon.com/OSXSpencer")!)
    }
    
    
}
