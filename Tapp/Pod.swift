//
//  Pod.swift
//  Tapp
//
//  Created by s on 2018-01-28.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireImage
import KeychainAccess

class Pod: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setFrameSize(NSSize(width: 620.0, height: 486.0))
       self.tabView.tabViewType = .noTabsNoBorder
        
    }
    
}

class MenuController: NSViewController, NSMenuDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProductSelector.setFrameSize(NSSize(width: 214, height: 100))
        self.ProductSelector.menu!.delegate = self
    }
    override func loadView() {
        super.loadView()
        //tabViewController = parent!.children[1] as! NSTabViewController
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
    }
    
    func menuDidClose(_ menu: NSMenu) {
        print(menu.highlightedItem?.title)
    }
    @IBOutlet weak var ProductSelector: NSPopUpButton!
    
    
    var tabViewController = NSTabViewController()
    //self.tabViewController.selectedTabViewItemIndex = 0

    
    
}

