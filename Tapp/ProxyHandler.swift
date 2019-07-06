//
//  ProxyHandler.swift
//  
//
//  Created by s on 2017-11-18.
//


import Cocoa
import Alamofire

class ProxyHandler: NSViewController {
    var requestManager = Alamofire.SessionManager.default
    func proxy() {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    
    var proxyConfiguration = [String: AnyObject]()
    proxyConfiguration.updateValue(1 as AnyObject, forKey: "HTTPEnable") //HTTPEnable
    proxyConfiguration.updateValue("PROXY" as AnyObject, forKey: "HTTPProxy") //URL
    proxyConfiguration.updateValue(0000 as AnyObject, forKey: "HTTPPort") //PORT
    proxyConfiguration.updateValue(1 as AnyObject, forKey: "HTTPSEnable") //ENABLE
    proxyConfiguration.updateValue("PROXY" as AnyObject, forKey: "HTTPSProxy") //Address
    proxyConfiguration.updateValue(0000 as AnyObject, forKey: "HTTPSPort") //PORT
    configuration.connectionProxyDictionary = proxyConfiguration
    
    requestManager = Alamofire.SessionManager(configuration: configuration)
    }
}
