//
//  SelectVehicle.swift
//  Tapp
//
//  Created by s on 2018-02-07.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireImage
import SwiftyJSON



class SelectVehicle : NSViewController, NSTableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let NumberOfVehicles = CVD.numOfVehicles
        self.tableView.delegate = self as NSTableViewDelegate
        self.tableView.dataSource = self
        self.Loading.animate(toDoubleValue: 1)
        for i in 0 ... (NumberOfVehicles - 1) {
            getcardata(i)
        }

        self.tableView.action = #selector(onItemClicked)
        
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindow.StyleMask.resizable)
        /*if(!UserDefaults.standard.bool(forKey: "EULA") && !CVD.EULA) {
            self.performSegue(withIdentifier: "SelectToEULA", sender: self)
            self.view.window?.close()
        } else {
            
        }*/
    }
    

    @IBOutlet weak var Loading: NSLevelIndicator!
    @IBOutlet weak var LoadingText: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    typealias record = (name: String, image: Image?, model: Character)
    var recs = [record]()
    var images = [Image]()

    
    @objc func onItemClicked() {
        
        CVD.SelectedVehicle = tableView.clickedRow
        self.performSegue(withIdentifier: "SelectToView", sender: self)
        self.view.window?.close()
    }
    
    
    
    
    func getcardata(_ Car: Int) {
        self.Loading.animate(toDoubleValue: 2)
        let vehicleid = CVD.vehicleIDs[Car]
        let url = URL(string:"https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleid)/data")
        
        var name: String = ""
        var model: Character = "s"
        var image: Image?
        
        let _ = Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: CVD.headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
            progress in
            }
            .validate { request, response, data in
                return .success
                
            }
            .responseJSON {
                response in
                let data = response.result.value
                switch(response.response?.statusCode) {
                case 200:
                    let json = JSON(data!)
                    print(json)
                    CVD.Data = json
                    let vehMod = json["response"]["vehicle_config"]["car_type"].stringValue
                    model = vehMod.last!
                    var carname = String()
                    if(JSON.checkNull(json["response"]["display_name"])) {
                        carname = json["response"]["display_name"].stringValue
                        name = carname
                    } else {
                        carname = "Error"
                    }
                    self.Loading.animate(toDoubleValue: 3)
                    
                    print("getimg int is \(Car)")
                    
                    
                    let options = CVD.optionCodes[Car]
                    let model = model
                    print(model)
                    let url = URL(string:"https://www.tesla.com/configurator/compositor/?model=m\(model)&view=STUD_SIDE&options=\(options)&bkba_opt=1&size=1920")
                    print(url!)
                    let _ = Alamofire.request(url!).responseImage { response in
                        let data = response.result.value
                        switch(response.response?.statusCode) {
                        case 200:
                            image = data!
                            self.view.alphaValue = 1.0
                            self.Loading.isHidden = true
                            self.LoadingText.isHidden = true
                            break
                        default:
                            print("yeah")
                            break
                        }
                    }
                        .response(completionHandler: { (response) in
                            print("completionCalled")
                            self.recs.append((name, image, model))
                            self.tableView.reloadData()
                        })
                default:
                    self.Loading.criticalFillColor = .red
                    print(response.response?.statusCode)
                    let data = response.result.value
                    let json = JSON(data)
                    self.LoadingText.stringValue = "Error"
                    print(json["error"].stringValue)
                    if(JSON.checkNull(json["error"])) {
                        let error = json["error"].stringValue
                        if(error == "vehicle unavailable: {:error=>\"vehicle unavailable:\"}") {
                            self.recs.append(("Vehicle Unavailable", NSImage(named: NSImage.cautionName), "-"))
                            self.tableView.reloadData()
                            
                        } else if(error == "mobile_access_disabled") {
                            self.recs.append(("Mobile Access Disabled", NSImage(named: NSImage.cautionName), "-"))
                            self.tableView.reloadData()
                        } else {
                            self.recs.append((json["error"].stringValue, NSImage(named: NSImage.cautionName), "-"))
                            self.tableView.reloadData()
                        }
                        
                    
                    }
                    self.view.alphaValue = 1.0
                    self.Loading.isHidden = true
                    self.LoadingText.isHidden = true
                    
                    /// MARK: LITE MODE
                    
                    
                    break
                }
                 
                }
        
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        
        // 1
        let item = recs[row]
        print(item)
        // 2
        text = item.name
        image = item.image
        
        // 3
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "VehicleCell"), owner: nil) as! NSTableCellView
            cell.textField!.stringValue = text
            cell.textField!.textColor = .white
            cell.imageView!.image = image
            cell.rowSizeStyle = .large
            print(cell.textField!.stringValue)
            return cell

    }
    
    
    
}
extension SelectVehicle: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return recs.count
    }
    
    
    
}
