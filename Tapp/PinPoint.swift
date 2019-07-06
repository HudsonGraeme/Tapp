//
//  PinPoint.swift
//  Tapp
//
//  Created by s on 2018-02-10.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
// The below is pretty disgusting, will clean later (never)

import Cocoa
import MapKit
import Alamofire
import SwiftyJSON


class PinPoint: NSViewController {
    
    @IBOutlet weak var Map: MKMapView!
    @IBOutlet weak var InfoBox: NSTextField!
    @IBOutlet weak var ProgBar: NSProgressIndicator!
    @IBOutlet weak var LoadLabel: NSTextField!
    
    override func viewDidLoad() {
        self.view.alphaValue = 0.5
        Map.mapType = .hybrid
        Map.showsTraffic = true
        Map.showsUserLocation = true
        getimg()
        self.loadData()
        Map.camera.altitude = 1000
        ProgBar.startAnimation(self)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if(CVD.locationTimer == 0.0) {
            CVD.locationTimer = 5.0
        }
        /*if(CVD.Data["response"]["drive_state"]["shift_state"].stringValue == "P"||CVD.Data["response"]["drive_state"]["shift_state"] == JSON.null) {
            self.PowerPowerPowerGraph.isHidden = true
        } else { //Debating adding this.. Kinda takes away from experience
            self.PowerPowerPowerGraph.isHidden = false
        }*/
        if(UserDefaults.standard.value(forKey: "PowerLevels") != nil) {
        CVD.PowerLevels = UserDefaults.standard.value(forKey: "PowerLevels") as! [Int]
        }
        timer = Timer.scheduledTimer(timeInterval: CVD.locationTimer, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear() {
        timer.invalidate()
    }
    var timer = Timer()
    
        var places = Place.getPlaces(CVD.Data)
        let locationManager = CLLocationManager()
        let v = CVD.SelectedVehicle
    
        @objc func loadData() {
            let ID = CVD.vehicleIDs[CVD.SelectedVehicle]
            _ = Alamofire.request("https://owner-api.teslamotors.com/api/1/vehicles/\(ID)/data_request/drive_state", method: .get, parameters: nil, encoding: URLEncoding.default, headers: CVD.headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
                progress in
                }
                .validate { request, response, data in
                    return .success
                    
                }
                .responseJSON {
                    response in
                    let data = response.result.value
                    if(data != nil) {
                        self.InfoBox.stringValue = ""
                        let json = JSON(data!)
                        
                        CVD.PowerLevels.append(json["response"]["power"].intValue)
                        UserDefaults.standard.set(CVD.PowerLevels, forKey: "PowerLevels")


                        
                        
                        self.Map.removeAnnotations(self.places)
                        let latitude:CLLocationDegrees = json["response"]["latitude"].doubleValue
                        let longitude:CLLocationDegrees = json["response"]["longitude"].doubleValue
                        let heading = json["response"]["heading"].floatValue
                        
                        if(json["response"]["shift_state"] == JSON.null || json["response"]["shift_state"].stringValue == "P") {
                            self.InfoBox.stringValue += "Vehicle Parked, facing \(json["response"]["heading"].intValue)°"
                            CVD.locationTimer = 30.0
                            self.timer.invalidate()
                            self.timer = Timer.scheduledTimer(timeInterval: CVD.locationTimer, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
                        } else {
                            let shiftState = json["response"]["shift_state"].stringValue
                            let speed = json["response"]["speed"].intValue
                            if(shiftState == "R") {
                                self.InfoBox.stringValue += "Vehicle in Reverse, "
                                self.InfoBox.stringValue += "travelling at \(speed)\(CVD.Data["response"]["gui_settings"]["gui_distance_units"].stringValue)"
                                self.InfoBox.stringValue += ", facing \(json["response"]["heading"].intValue)°"
                            } else if(shiftState == "D") {
                                self.InfoBox.stringValue += "Vehicle in Drive, "
                               self.InfoBox.stringValue += "travelling at \(speed)\(CVD.Data["response"]["gui_settings"]["gui_distance_units"].stringValue)"
                               self.InfoBox.stringValue += ", facing \(json["response"]["heading"].intValue)°"
                            } else if(shiftState == "N") {
                                self.InfoBox.stringValue += "Vehicle in Neutral, "
                                self.InfoBox.stringValue += "travelling at \(speed)\(CVD.Data["response"]["gui_settings"]["gui_distance_units"].stringValue)"
                                self.InfoBox.stringValue += ", facing \(json["response"]["heading"].intValue)°"
                            }
                            CVD.locationTimer = 5.0
                            self.timer.invalidate()
                            self.timer = Timer.scheduledTimer(timeInterval: CVD.locationTimer, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
                        }
                        let mapzoom = self.Map.camera.altitude
                        
                        
                        let latDelta:CLLocationDegrees = 0.05
                        
                        let lonDelta:CLLocationDegrees = 0.05
                        
                        let span = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
                        
                        let location = CLLocationCoordinate2DMake(latitude, longitude)
                        
                        let region = MKCoordinateRegion.init(center: location, span: span)
                        self.Map.setRegion(region, animated: false)
                        self.Map.camera.altitude = mapzoom
                        self.Map.camera.heading = CLLocationDirection(heading)
                        self.places = Place.getPlaces(json)
                        self.addAnnotations()
                        if(self.view.alphaValue != 1.0) {
                        self.view.alphaValue = 1.0
                        }
                        if(!self.ProgBar.isHidden) {
                        self.ProgBar.isHidden = true
                        }
                        if(!self.LoadLabel.isHidden) {
                            self.LoadLabel.isHidden = true
                        }
                    }
                    else {
                        print("error")
                    }
            }
    }
    
    func addAnnotations() {
        Map?.delegate = self
        Map?.addAnnotations(places)
        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 50) }
        Map?.addOverlays(overlays)
    }
    
    func getimg() {
        let options = CVD.optionCodes[v]
        let model = CVD.VehicleTrims[v]
        let url = URL(string:"https://www.tesla.com/configurator/compositor/?model=m\(model)&view=STUD_SEAT_ABOVE&options=\(options)&bkba_opt=1&size=1920")
        let _ = Alamofire.request(url!).responseImage { response in
            let data = response.result.value
            if(data != nil) {
            CVD.VehicleAbov = data!
            self.addAnnotations()
            }
        }
    }
}

@objc class Place: NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    static func getPlaces(_ json: JSON) -> [Place] {
        
        var places = [Place]()
        let jsond = CVD.Data
        let latitude = json["response"]["latitude"].doubleValue
        let longitude = json["response"]["longitude"].doubleValue
        let vehicleName = jsond["response"]["display_name"].stringValue
        var description = "Error occured \r\n Please contact me: \r\n Spencer@carspotter.ca"
        if(json["response"]["shift_state"] != JSON.null && json["response"]["shift_state"].stringValue != "P") {
            description = "Speed \(json["response"]["speed"].intValue)\(jsond["response"]["gui_settings"]["gui_distance_units"].stringValue) \r\n Power \(json["response"]["power"].intValue) \r\n Latitude \(json["response"]["latitude"].doubleValue) \r\n Longitude \(json["response"]["longitude"].doubleValue))"
        } else {
            description = "Vehicle parked \r\n Latitude \(json["response"]["latitude"].doubleValue) \r\n Longitude \(json["response"]["longitude"].doubleValue) \r\n Heading \(json["response"]["heading"])°"
        }
        places.append(Place(title: vehicleName, subtitle: description, coordinate: CLLocationCoordinate2DMake(latitude, longitude)))
        
        return places as [Place]
    }
}

extension Place: MKAnnotation { }

extension NSViewController: MKMapViewDelegate {
    /*public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            #imageLiteral(resourceName: "Nav").size = NSSize(width: 40.0, height: 40.0)
            let json = CVD.Data
            annotationView.image = #imageLiteral(resourceName: "Nav").imageRotatedByDegreess(degrees: CGFloat((json["response"]["drive_state"]["heading"].floatValue - 100)))
            
            return annotationView
        }
    }*/
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        annotationView.canShowCallout = true
        #imageLiteral(resourceName: "Nav").size = NSSize(width: 40.0, height: 40.0)
        annotationView.image = #imageLiteral(resourceName: "Nav").imageRotatedByDegreess(degrees: 45.0)
        return annotationView
    }
    
    /*public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = NSColor.black.withAlphaComponent(0.3)
        renderer.strokeColor = NSColor.systemBlue
        renderer.lineWidth = 2
        return renderer
     }*/
    

    
}
public extension NSImage {
    public func imageRotatedByDegreess(degrees:CGFloat) -> NSImage {
        
        var imageBounds = NSZeroRect ; imageBounds.size = self.size
        let pathBounds = NSBezierPath(rect: imageBounds)
        var transform = NSAffineTransform()
        transform.rotate(byDegrees: degrees)
        pathBounds.transform(using: transform as AffineTransform)
        let rotatedBounds:NSRect = NSMakeRect(NSZeroPoint.x, NSZeroPoint.y , self.size.width, self.size.height )
        let rotatedImage = NSImage(size: rotatedBounds.size)
        
        //Center the image within the rotated bounds
        imageBounds.origin.x = NSMidX(rotatedBounds) - (NSWidth(imageBounds) / 2)
        imageBounds.origin.y  = NSMidY(rotatedBounds) - (NSHeight(imageBounds) / 2)
        
        // Start a new transform
        transform = NSAffineTransform()
        // Move coordinate system to the center (since we want to rotate around the center)
        transform.translateX(by: +(NSWidth(rotatedBounds) / 2 ), yBy: +(NSHeight(rotatedBounds) / 2))
        transform.rotate(byDegrees: degrees)
        // Move the coordinate system bak to normal
        transform.translateX(by: -(NSWidth(rotatedBounds) / 2 ), yBy: -(NSHeight(rotatedBounds) / 2))
        // Draw the original image, rotated, into the new image
        rotatedImage.lockFocus()
        transform.concat()
        self.draw(in: imageBounds, from: NSZeroRect, operation: NSCompositingOperation.copy, fraction: 1.0)
        rotatedImage.unlockFocus()
        
        return rotatedImage
}
}
