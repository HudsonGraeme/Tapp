//
//  Extensions.swift
//  ADB
//
//  Created by s on 2017-10-02.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import AlamofireImage
import SwiftyJSON


extension NSView {
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer?.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromRight(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer?.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    
    func slideInFromTop(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromTopTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromTopTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromTopTransition.type = CATransitionType.push
        slideInFromTopTransition.subtype = CATransitionSubtype.fromTop
        slideInFromTopTransition.duration = duration
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromTopTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer?.add(slideInFromTopTransition, forKey: "slideInFromTopTransition")
    }
    
    func slideInFromBottom(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromBottomTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromBottomTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromBottomTransition.type = CATransitionType.push
        slideInFromBottomTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromBottomTransition.duration = duration
        slideInFromBottomTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromBottomTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer?.add(slideInFromBottomTransition, forKey: "slideInFromBottomTransition")
    }
    func fadeIn(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let fadeIn = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            fadeIn.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        fadeIn.type = CATransitionType.fade
        fadeIn.subtype = CATransitionSubtype.fromBottom
        fadeIn.duration = duration
        fadeIn.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        fadeIn.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer?.add(fadeIn, forKey: "fadeIn")
    }

    
    
    
    
}

extension FileManager {
    class func documentsDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    class func desktopDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}

extension JSON {
    static func checkNull(_ input: JSON) -> Bool{
        if(input == JSON.null) {
            return false
        } else {
            return true
        }
}
}



@available(OSX 10.12.2, *)

extension NSViewController {
    class func WakeUp(ID VehicleID: Int) {
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(VehicleID)/wake_up")
        _ = Alamofire.request(url!, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: [:]).responseJSON { response in

        }
    }
}


func Alert(_ title:String,_ text:String,_ style:NSAlert.Style,_ buttonCount:Int, _ buttonNames:NSArray) -> Int {
    var count = buttonCount
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = text
    alert.alertStyle = style
    while count >= 1 {
        let name = buttonNames[count - 1] as! String
        alert.addButton(withTitle: name)
        count = count - 1
    }
    
    let stackViewer = NSStackView()
    
    alert.accessoryView = stackViewer
    alert.addVisualEffectView()
    
    let response: NSApplication.ModalResponse = alert.runModal()
    return response.rawValue
}

extension NSAlert {
    func addVisualEffectView() {
        let EffectView = NSVisualEffectView(frame: self.window.frame)
        EffectView.material = .popover
        EffectView.blendingMode = .behindWindow
        EffectView.state = .active
        for (subview) in (self.window.contentView!.subviews) {
            EffectView.subviews.append(subview)
        }
        self.window.styleMask.insert(.fullSizeContentView)
        self.window.isMovableByWindowBackground = true
        self.window.styleMask.insert(.borderless)
        self.window.contentView!.subviews.removeAll()
        self.window.titlebarAppearsTransparent = true
        self.window.titleVisibility = .hidden
        self.window.contentView = EffectView
        self.window.contentView!.wantsLayer = true
        self.window.contentView!.layer!.cornerRadius = 10.0
        self.window.backgroundColor = .clear
        self.window.isOpaque = false
    }
    
}

extension NSAttributedString {
    func setColorForText(attrStr:NSMutableAttributedString, _ textToFind: String, with color: NSColor) {
        let inputLength = attrStr.string.count
        let searchString = textToFind
        let searchLength = searchString.count
        var range = NSRange(location: 0, length: attrStr.length)
        while (range.location != NSNotFound) {
            range = (attrStr.string as NSString).range(of: searchString, options: [], range: range)
            if (range.location != NSNotFound) {
                attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: range.location, length: searchLength))
                range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
            }
        }
    }
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}


extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        print(request.httpBody!)
        return request
    }
}

func increaseRect(rect: CGRect, byPercentage percentage: CGFloat) -> CGRect {
    let startWidth = rect.width
    let startHeight = rect.height
    let adjustmentWidth = (startWidth * (percentage / 100)) / 2.0
    let adjustmentHeight = (startHeight * (percentage / 100)) / 2.0
    return rect.insetBy(dx: -adjustmentWidth, dy: -adjustmentHeight)
}


class LevelIndicatorAnimation: NSAnimation {
    weak var progInd: NSLevelIndicator?
    var initialValue: Double = 0.0
    var newValue: Double = 0.0
    
    init(progressBar ind: NSLevelIndicator?, newDoubleValue val: Double) {
        super.init(duration: 0.50, animationCurve: NSAnimation.Curve.linear)
        progInd = ind
        initialValue = progInd?.doubleValue ?? 0.0
        newValue = val
        animationBlockingMode = .nonblocking
        
    }
    
    override var currentProgress: NSAnimation.Progress {
        get {
            return super.currentProgress
        }
        set(currentProgress) {
            super.currentProgress = currentProgress
            
            let delta: Double = newValue - initialValue
            
            progInd?.doubleValue = initialValue + (delta * Double(currentValue)) //changed from currentProgress to currentValue to take into account animationCurves. Thanks, Alan B. for the tip
            
            if Double(currentProgress) == 1.0 && progInd?.responds(to: #selector(NSLevelIndicator.animationDealloc)) ?? false {
                progInd?.animationDealloc()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private var anim: LevelIndicatorAnimation? = nil

extension NSLevelIndicator {
    func animate(toDoubleValue val: Double) {
        if anim != nil {
            let oldToValue: Double? = anim?.newValue
            anim?.stop()
            anim = nil
            doubleValue = oldToValue ?? 0.0
        }
        
        anim = LevelIndicatorAnimation(progressBar: self, newDoubleValue: val)
        anim?.start()
    }
    
    @objc func animationDealloc() {
        anim?.stop()
        anim = nil
    }
}

extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

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
