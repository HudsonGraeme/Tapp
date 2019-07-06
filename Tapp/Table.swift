//
//  Table.swift
//  Tapp
//
//  Created by s on 2017-11-01.
//  Copyright © 2017 Carspotter Daily. All rights reserved.
//

import Cocoa

class Vieww: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let filePath = Bundle.main.path(forResource: "Feeds", ofType: "plist") {
            table = TableItem.TableList(filePath)
            print(table)
        }
    }
    
    @IBOutlet weak var TableView: NSOutlineView!
    var table = [Table]()
    
}


class Table: NSObject {
    let name: String
    var children = [TableItem]()
    
    init(name: String) {
        self.name = name
    }
}

class TableItem: NSObject {
    let url: String
    let title: String
    let publishingDate: Date
    
    init(dictionary: NSDictionary) {
        self.url = dictionary.object(forKey: "url") as! String
        self.title = dictionary.object(forKey: "title") as! String
        self.publishingDate = dictionary.object(forKey: "date") as! Date
    }
    class func TableList(_ fileName: String) -> [Table] {
        //1
        var tables = [Table]()
        
        //2
        if let TableList = NSArray(contentsOfFile: fileName) as? [NSDictionary] {
            //3
            for TableItems in TableList {
                //4
                let table = Table(name: TableItems.object(forKey: "name") as! String)
                //5
                let items = TableItems.object(forKey: "items") as! [NSDictionary]
                //6
                for dict in items {
                    //7
                    let item = TableItem(dictionary: dict)
                    table.children.append(item)
                }
                //8
                tables.append(table)
            }
        }
        
        //9
        return tables
    }
}
