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
