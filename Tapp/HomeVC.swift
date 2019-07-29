//
//  HomeVC.swift
//  Tapp
//
//  Created by D. graham on 2019-07-19.
//  Copyright © 2019 Carspotter Daily. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import CoreGraphics

let disabledButtonColour = CGColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
let highlightButtonColour = CGColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
let offButtonColour = CGColor(red: 2.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 0.0)
let OnButtonColour = CGColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)

typealias colorscheme = (foreground: NSColor, background: CGColor)




extension NSBezierPath {
    
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            default:
                path.closeSubpath()
            }
        }
        
        return path
    }
}

extension NSImage {
    func tint(color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()
        
        color.set()
        
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)
        
        image.unlockFocus()
        
        return image
    }
}

enum NotificationType {
    case success
    case warn
    case error
    case info
}

extension NSView {
    
    
    func presentNotification(withType type: NotificationType, withMessage message: String) {
        let NotificationView = NSView(frame: NSRect(x: 0, y: self.bounds.height - 80, width: self.bounds.width, height: 40))
        NotificationView.center = NSPoint(x: self.center.x, y: self.bounds.maxY-20)
        let textView = NSTextField()
        textView.setFrameSize(NSSize(width: self.frame.width - 80, height: 40))
        textView.frame.origin.x = NotificationView.bounds.origin.x+40
        textView.frame.origin.y = NotificationView.bounds.origin.y-10
        textView.stringValue = message
        textView.backgroundColor = .clear
        textView.drawsBackground = false
        textView.isBordered = false
        textView.font = NSFont(name: "Arial", size: 15.0)
        textView.alignment = .center
        textView.textColor = .white
        textView.alphaValue = 1.0
        let iconView = NSImageView()
        iconView.frame.origin = NSPoint(x: NotificationView.bounds.origin.x+5, y: NotificationView.bounds.origin.y)
        iconView.setFrameSize(NSSize(width: 40, height: 40))
        NotificationView.wantsLayer = true
        switch(type) {
        case .success:
            NotificationView.layer!.backgroundColor = NSColor.systemGreen.cgColor
            iconView.image = NSImage(named: NSImage.statusAvailableName)
        case .info:
            NotificationView.layer!.backgroundColor = NSColor.systemGray.cgColor
            iconView.image = NSImage(named: NSImage.infoName)
        case .warn:
            NotificationView.layer!.backgroundColor = NSColor.systemOrange.cgColor
            iconView.image = NSImage(named: NSImage.cautionName)
        default:
            NotificationView.layer!.backgroundColor = NSColor.systemRed.cgColor
            iconView.image = NSImage(named: NSImage.cautionName)
        }
        NotificationView.layer!.backgroundColor = NotificationView.layer!.backgroundColor?.copy(alpha: 0.5)
        print(textView.frame,iconView.frame,NotificationView.frame)
        NotificationView.addSubview(textView)
        NotificationView.addSubview(iconView)
        self.addSubview(NotificationView)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 3.5
                NotificationView.animator().alphaValue = 0.0
            }, completionHandler: {
                NotificationView.removeFromSuperview()
            })
        }
       
        
    }
    
    func centerInSuperview(superview withSuperview: NSView?) {
        var superview = self.superview
        if(withSuperview != nil) {
            superview = withSuperview
        }
        self.frame.origin = NSPoint(x: superview!.bounds.midX - self.frame.width / 2, y: superview!.bounds.midY-self.frame.height/2)
    }
    
    var center: NSPoint {
        get {
            let centerX = self.frame.origin.x + (self.frame.size.width / 2)
            let centerY = self.frame.origin.y + (self.frame.size.height / 2)
            return NSPoint(x: centerX, y: centerY)
        }
        set {
            self.frame.origin.x = newValue.x - (self.frame.size.width / 2)
            self.frame.origin.y = newValue.y - (self.frame.size.height / 2)
        }
    }
    
    
    
    func buildRect(inView view: NSView, _ buttons: [NSButton], withTarget target: AnyObject?, withSelector selector: Selector, customSpacing spacing: CGFloat?) {
        
        let path = NSBezierPath(roundedRect: view.bounds, xRadius: 15, yRadius: 15)
        //path.windingRule = .evenOdd
        var buttonsPerColumn: CGFloat = 1
        while ((CGFloat(buttons.count)/buttonsPerColumn*(view.frame.width/CGFloat(buttons.count))) >= view.frame.width) {
            buttonsPerColumn += 1
        }
        
        let buttonsPerRow = CGFloat(buttons.count) / buttonsPerColumn
        let maxX = buttonsPerRow*(view.frame.width/buttonsPerRow)
        print(maxX)
        var buttonGrid = [[NSButton]]()
        for i in 0..<Int(buttonsPerRow) {
            var buttonsInRow = [NSButton]()
            for x in 0..<Int(buttonsPerColumn)
            {
                buttonsInRow.append(buttons[(x*2)+i])
            }
            buttonGrid.append(buttonsInRow)
        }
        
       
        for buttonsArr in buttonGrid {
            for button in buttonsArr {
                button.setFrameOrigin(view.frame.origin)
                if(spacing != nil) {
                    let offset = NSPoint(x: view.frame.width/spacing!, y: view.frame.height/spacing!)
                    let x = spacing!*(CGFloat(buttonGrid.firstIndex(of: buttonsArr)!))*(view.frame.width/buttonsPerRow)
                    let y = (CGFloat(buttonsArr.firstIndex(of: button)!)*view.frame.height/buttonsPerColumn)
                    button.center.x = x+offset.x
                    button.center.y = y+offset.y
                    
                } else {
                    let offset = NSPoint(x: view.frame.width/buttonsPerRow/buttonsPerColumn, y: view.frame.height/buttonsPerColumn/buttonsPerRow)
                    let x = (CGFloat(buttonGrid.firstIndex(of: buttonsArr)!)*(view.frame.width/buttonsPerRow))
                    let y = (CGFloat(buttonsArr.firstIndex(of: button)!)*view.frame.height/buttonsPerColumn)
                button.center = NSPoint(x: x+offset.x, y: y+offset.y)
                }
                print(button.center)
                if let img = button.image {
                button.image = nil
                button.standardize(withImage: img, withSuperView: view)
                } else {
                   button.standardize(withImage: #imageLiteral(resourceName: "lightning"), withSuperView: view)
                }
                self.addSubview(button)
                let bpath = NSBezierPath(ovalIn: button.frame)
                path.append(bpath)
                button.center.x += view.frame.minX - self.frame.minX
                button.center.y += view.frame.minY - self.frame.minY
                //button.setButtonType(.onOff)
                button.target = target
                button.action = selector
            }
        }
        
        let fillLayer = CAShapeLayer()
        fillLayer.frame = view.bounds
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = .black
        fillLayer.opacity = 0.5
        view.layer = fillLayer
        self.addSubview(view)
    }
}


extension NSButton {
    
    func setColor(_ colorscheme: colorscheme) {
        for view in self.subviews {
            if let imageView = view as? NSImageView {
                imageView.image = imageView.image?.tint(color: colorscheme.foreground)
            }
        }
        self.layer!.backgroundColor = colorscheme.background
    }
    
    func standardize(withImage image: NSImage, withSuperView view: NSView) {
        
        self.subviews.removeAll()
        self.bezelColor = .clear
        self.wantsLayer = true
        self.layer!.isOpaque = false
        self.layer!.cornerRadius = (self.frame.width / 2) - 2
        self.layer!.backgroundColor = offButtonColour
        self.bezelStyle = .circular
        self.isBordered = false
        let imageSubview = NSImageView()
        imageSubview.setFrameSize(NSSize(width: self.bounds.width-10,height: self.bounds.height-10))
        imageSubview.centerInSuperview(superview: self)
        imageSubview.image = image
        self.addSubview(imageSubview)
        let enterExitArea = NSTrackingArea(rect: self.bounds,
                                       options: [.mouseEnteredAndExited,  .activeAlways],
                                       owner: self,
                                       userInfo: ["Button":self])
        self.addTrackingArea(enterExitArea)
        self.imagePosition = .imageOnly

    }
    
    
/*
     ORIGINAL
        NSRect(x: 35+(radius*2), y: ControlRect.height - (ButtonRect.height*2 + 30), width:  2*radius+10, height: 2*radius+10)
     HOLE
        NSRect(x: 35+(radius*2), y: ControlRect.height - (ButtonRect.height*2 + 30), width:  2*radius+10, height: 2*radius+10)
     
     
 */



}


class HomeVC : NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("View Frame: \(self.view.frame)")
        
        let ControlRect = NSRect(x: self.view.frame.minX + 30, y: self.view.frame.maxY - 240, width: 140, height: 160)
        
        let v1 = NSView(frame: ControlRect)
        v1.center = self.view.center
        let ButtonRect = CGRect(origin: CGPoint(x: 70, y: 430), size: CGSize(width: 40, height: 40))
        
        let ButtonOne = NSButton(frame: ButtonRect)
        
        let ButtonTwo = NSButton()
        ButtonTwo.setFrameSize(NSSize(width: 40, height: 40))
        
        let ButtonThree = NSButton()
        ButtonThree.setFrameSize(NSSize(width: 40, height: 40))
        let ButtonFour = NSButton()
        ButtonFour.setFrameSize(NSSize(width: 40, height: 40))
        ButtonFour.title = "FlashLights"
        ButtonThree.title = "Unlock"
        ButtonOne.image = #imageLiteral(resourceName: "lightning")
        ButtonTwo.image = #imageLiteral(resourceName: "headlamp")
        ButtonThree.image = #imageLiteral(resourceName: "unlock")
        ButtonFour.image = #imageLiteral(resourceName: "horn")

        
        self.view.buildRect(inView: v1, [ButtonOne, ButtonTwo, ButtonThree,ButtonFour], withTarget: self, withSelector: #selector(HomeVC.onButtonPress(_:)), customSpacing: nil)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
    }
    
    @objc func onButtonPress(_ sender: NSButton) {
        
        
        if (sender.title == "Unlock") {
            if (sender.state == .off) {
                sender.standardize(withImage: #imageLiteral(resourceName: "unlock"), withSuperView: sender.superview!)
                sender.slideInFromTop()
                sender.setColor((.white, offButtonColour))
            } else {
                sender.standardize(withImage: #imageLiteral(resourceName: "lock"), withSuperView: sender.superview!)
                sender.slideInFromBottom()
                sender.setColor((.black, OnButtonColour))
            }
        } else if (sender.title == "FlashLights") {
            self.view.presentNotification(withType: .success, withMessage: "Sucessfully honked the horn")
            
        } else {
            if (sender.state == .off) {
                self.view.presentNotification(withType: .error, withMessage: "Could not flash vehicle lights")
                sender.setColor((.white,offButtonColour))
            } else {
                sender.setColor((.black,OnButtonColour))
            }
        }
        
    }
    
    
}

