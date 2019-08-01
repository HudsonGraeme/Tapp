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
import SwiftWebSocket
import CoreLocation



/*
 var Socketrequest = URLRequest(url: URL(string:"wss://streaming.vn.teslamotors.com/connect/\(self.vehicles!.response[0].vehicleID)")!)
 var auth = "bugrocco@gmail.com:\(self.vehicles!.response[0].tokens[0])"
 auth = auth.base64Encoded()!
 request.addValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
 request.addValue("* / *", forHTTPHeaderField: "Accept")
request.addValue("SGVsbG8sIHevcmxkIQ==", forHTTPHeaderField: "Sec-WebSocket-Key")
request.addValue("13", forHTTPHeaderField: "Sec-WebSocket-Version")
request.addValue("Upgrade", forHTTPHeaderField: "Connection")
request.addValue("websocket", forHTTPHeaderField: "Upgrade")
request.addValue("streaming.vn.teslamotors.com", forHTTPHeaderField: "Host")
request.addValue("wss://streaming.vn.teslamotors.com", forHTTPHeaderField: "Origin")

let ws = WebSocket(request: request)

ws.event.open = {
    print("opened")
    ws.send("{\"msg_type\":\"autopark:cmd_forward\", \"latitude\":43.193519, \"longitude\": -79.821651}")
    let queue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).HeartBeat")  // you can also use `DispatchQueue.main`, if you want
    let timer = DispatchSource.makeTimerSource(queue: queue)
    timer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
    timer.setEventHandler { [weak self] in
        ws.send("{\"msg_type\":\"autopark:heartbeat_app\", \"timestamp\":\(NSTimeIntervalSince1970)}")
    }
    timer.resume()
}
ws.event.error = { error in
    print(error)
    
}
var messageCount = 0
ws.event.message = { message in
    if let string = String(bytes: message as! [UInt8], encoding: .utf8) {
        print(string)
    } else {
        print("not a valid UTF-8 sequence")
    }
    messageCount += 1
    if(messageCount > 3 && messageCount < 5) {
        ws.send("{\"msg_type\":\"control:ping\", \"timestamp\":\(NSTimeIntervalSince1970)}")
        //ws.send("{\"msg_type\":\"autopark:cmd_forward\", \"latitude\":43.193519, \"longitude\": -79.821651}")
    }
}
ws.open()
 
 */




class HomeVC : NSViewController, CLLocationManagerDelegate {
    
    
    // WebSocket Stuff
    
    var socketRequest: URLRequest? = nil
    var auth: String? = nil
    var ws = WebSocket()
    let timer = DispatchSource.makeTimerSource(queue: .main)
    
    var vehicles: Vehicles? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //More Websocket stuff
        socketRequest = URLRequest(url: URL(string:"wss://streaming.vn.teslamotors.com/connect/\(self.vehicles!.response[0].vehicleID)")!)
        auth = "bugrocco@gmail.com:\(self.vehicles!.response[0].tokens[0])".base64Encoded()!
        

        socketRequest!.addValue("Basic \(auth!)", forHTTPHeaderField: "Authorization")
        socketRequest!.addValue("* / *", forHTTPHeaderField: "Accept")
        socketRequest!.addValue("SGVsbG8sIHevcmxkIQ==", forHTTPHeaderField: "Sec-WebSocket-Key")
        socketRequest!.addValue("13", forHTTPHeaderField: "Sec-WebSocket-Version")
        socketRequest!.addValue("Upgrade", forHTTPHeaderField: "Connection")
        socketRequest!.addValue("websocket", forHTTPHeaderField: "Upgrade")
        socketRequest!.addValue("streaming.vn.teslamotors.com", forHTTPHeaderField: "Host")
        socketRequest!.addValue("wss://streaming.vn.teslamotors.com", forHTTPHeaderField: "Origin")
        
        /*.request(URL(string: "https://owner-api.teslamotors.com/api/1/vehicles/\(vehicles!.response[0].id)/wake_up")!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            }.response { (response) in
                print(response)
        }*/
        
        
        
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
         ws = WebSocket(request: socketRequest!)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    @IBAction func sumFwd(_ sender: Any) {
        self.ws.event.open = {
            print("opened")
        }
        self.ws.event.error = { error in
            print(error)
            
        }
        var messageCount = 0
        self.ws.event.message = { message in
            
            
            if let string = String(bytes: message as! [UInt8], encoding: .utf8) {
                
                if let statemsg = try? StreamStateMessage(string) {
                    print("State: ", statemsg.autoparkState, "\t", statemsg.autoparkStateReason)
                } else if let heartbeatmsg = try? StreamHeartbeat(string) {
                    print("Heartbeat: ", heartbeatmsg.carTimestamp, "\t", heartbeatmsg.timestamp)
                } else if let movemsg = try? StreamMoveData(string) {
                    print("Shift State:", movemsg.shiftState, "\nLocation: ", movemsg.latitude, ", ", movemsg.longitude, "\nHeading: ", movemsg.heading)
                    
                } else if let hellomsg = try? HelloMessage(string) {
                    print("Server Hello: Timeout \(hellomsg.connectionTimeout)ms\nAutopark Heartbeat Frequency: \(hellomsg.autopark.heartbeatFrequency)\nAutopark Pause Timeout: \(hellomsg.autopark.autoparkPauseTimeout)\n Autopark Stop Timeout: \(hellomsg.autopark.autoparkStopTimeout)")
                } else if let styleMsg = try? AutoparkStyle(string) {
                    print("Style: ", styleMsg.autoparkStyle)
                } else if let homelinkMsg = try? HomelinkMessage(string) {
                    print("Homelink Nearby: \(homelinkMsg.homelinkNearby)")
                    self.ws.send("{\"msg_type\":\"autopark:cmd_reverse\", \"latitude\":\(43.193428), \"longitude\": \(-79.821680)}")
                } else {
                 print(string)
                }
                
                
            } else {
                print("not a valid UTF-8 sequence")
            }
            messageCount += 1
        }
        let manager = CLLocationManager()
        manager.delegate = self
    
        manager.startUpdatingLocation()
        manager.requestLocation()
        //let lat = manager.location?.coordinate.latitude
        //let long = manager.location?.coordinate.longitude
        print(manager.location?.coordinate)
        self.ws.open()
        self.timer.schedule(deadline: .now() + .seconds(11), repeating: .milliseconds(1000))
        self.timer.setEventHandler { [weak self] in
            self!.ws.send("{\"msg_type\":\"autopark:heartbeat_app\", \"timestamp\":\(NSDate().timeIntervalSince1970*1000)}")
        }
        self.timer.resume()
        
    }
    
    @IBAction func StopSum(_ sender: Any) {
        self.ws.send("{\"msg_type\":\"autopark:cmd_abort\"}")
        self.timer.suspend()
        ws.close()
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
                sender.setColor((.white,highlightButtonColour))
            }
        }
        
    }
    
    
}

