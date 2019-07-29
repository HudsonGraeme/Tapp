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
        //0self.tabView.tabViewBorderType = .none
    }
    
}
class SplitView : NSSplitViewController {
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        self.view.window!.titleVisibility = .hidden
        self.view.window!.styleMask = .fullSizeContentView
        self.view.wantsLayer = true
        self.view.layer!.cornerRadius = 10.0
        self.view.window!.isOpaque = false
        self.view.window!.backgroundColor = .clear
        self.view.window!.isMovableByWindowBackground = true
    }
    
    override func splitView(_ splitView: NSSplitView, shouldHideDividerAt dividerIndex: Int) -> Bool {
        return true
    }
    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return NSZeroRect
    }
    
}


class MenuController: NSViewController, NSTableViewDelegate, NSTableViewDataSource{
    // *********SELECTOR**********
    var vehicles: Vehicles? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setFrameSize(NSSize(width: self.view.frame.width, height: super.view.frame.height))
        //self.view.wantsLayer = true
        //self.view.layer!.cornerRadius = 10.0
        let group = DispatchGroup()
        for (vehicle) in (vehicles!.response) {
           group.enter()
            Alamofire.request("https://www.tesla.com/configurator/compositor/?model=m\(vehicle.vin[vehicle.vin.index(vehicle.vin.startIndex, offsetBy: 3)].lowercased())&view=STUD_SIDE&options=\(vehicle.optionCodes)&bkba_opt=1&size=1920").responseImage { (img) in
                vehicle.image = img.value
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.scrollView.wantsLayer = true
            self.scrollView.layer!.cornerRadius = 10.0
            self.tableView.headerView = nil
            self.tableView.action = #selector(self.onItemClicked)
            self.scrollView.isHidden = false
            self.tableView.reloadData()
            self.tableView.setFrameSize(NSSize(width: self.tableView.frame.size.width, height: CGFloat(self.vehicles!.count*100)+10))
            self.scrollView.setFrameSize(NSSize(width: self.tableView.frame.size.width, height: CGFloat(self.vehicles!.count*100)+10))
            self.ProductSelectButton.imagePosition = .imageLeft
            
        }
        // **********SELECTOR************
        
        }
     // **********SELECTOR************
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var ProductSelectButton: NSButton!

    func numberOfColumns(in tableView: NSTableView) -> Int {
        return 1
    }

   func numberOfRows(in tableView: NSTableView) -> Int {
        return vehicles!.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }
    
    override func mouseEntered(with event: NSEvent) {
        // Identify which button triggered the mouseEntered event
        if let vehicle = event.trackingArea?.userInfo?.values.first as? Int {
            let cell = tableView.view(atColumn: 0, row: vehicle, makeIfNecessary: false) as! NSTableCellView
                cell.imageView?.slideInFromRight()
        }
    }
    
    @objc func onItemClicked() {
        if(tableView.clickedColumn > -1 && tableView.clickedRow > -1) {
        self.scrollView.isHidden = true
        let cell = self.tableView.view(atColumn: tableView.clickedColumn, row: tableView.clickedRow, makeIfNecessary: false) as! NSTableCellView
        self.ProductSelectButton.title = cell.textField!.stringValue
        self.ProductSelectButton.image = cell.imageView!.image
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let vehicle = vehicles!.response[row]
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView else { return nil }
        if(row == 0) {
            self.ProductSelectButton.image = vehicle.image
            self.ProductSelectButton.title = vehicle.displayName
        }

        cell.imageView?.image = vehicle.image
        cell.imageView?.setFrameSize(NSSize(width: cell.frame.width, height: cell.frame.height - 20))
        cell.imageView?.frame.origin.y -= 30
        cell.textField?.stringValue = vehicle.displayName
        cell.textField?.alignment = .center
        cell.rowSizeStyle = .custom
        let area = NSTrackingArea.init(rect: cell.bounds,
                                       options: [.mouseEnteredAndExited, .activeAlways],
                                       owner: self,
                                       userInfo: ["Vehicle":row])
        cell.addTrackingArea(area)
        return cell
    }

        // **********SELECTOR************
    
    
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
    }
    

    



    
    @IBAction func ProductSelectButton(_ sender: Any) {
        if(self.scrollView.isHidden) {
        self.scrollView.isHidden = false
        } else {
            self.scrollView.isHidden = true
        }
    }
    
    
    var tabViewController = NSTabViewController()
    //self.tabViewController.selectedTabViewItemIndex = 0

    
    
}

