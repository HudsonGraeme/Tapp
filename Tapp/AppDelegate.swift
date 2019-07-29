//
//  AppDelegate.swift
//  Tapp
//
//  Created by Hudson Graeme on 2017-01-06.
//  

import Cocoa
import KeychainAccess

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
 
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
 
    let keychain = Keychain(service: "HudsonGraeme.Dev.Tapp")
        public func cData() {
        print("Hello!")
        do {
            try keychain.removeAll()
            }
        catch {
            print("Keychain couldn't delete any data")
        }
            
        if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
            
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApplication.shared.registerForRemoteNotifications(matching: .alert)
    }

    func applicationDidResignActive(_ notification: Notification) {
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        exit(0);
    }
    

}

