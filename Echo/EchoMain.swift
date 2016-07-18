//
//  EchoMain.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EchoMain {
    
    static let shared = EchoMain()
    
    static func echoShared() -> EchoMain {
        return shared
    }
    
    // MARK: - Variables
    
    //API Connections for device details
    let deviceUUID = NSUUID().UUIDString
    let deviceName = UIDevice.currentDevice().name
    let appTitle = "Circles"
    
    // Setup and Binding to window
    private(set) var bindedToWindow: UIWindow!
    private(set) var isStarted: Bool = false
    
    // MARK: - Create and connect to view
    func presentEchoInNewWindow() {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds);
        window.backgroundColor = UIColor.whiteColor()
        presentEchoInWindow(window)
        window.makeKeyAndVisible()
    }
    
    // MARK: - Create Echo Instance
    func createEcho() {
        print("\(deviceUUID) ---- \(deviceName)")
        
        // Locale
        for lang in NSLocale.preferredLanguages() {
            print("Found locale :\(lang)")
        }
        
        // TimeZone
        let timeZone = NSTimeZone.defaultTimeZone().name
        print("Found time zone :\(timeZone)")
        
        isStarted = true
    }
    
    func presentEchoInWindow(window: UIWindow) {
        
        // This will stop the app and revert back if Echo is not started correctly: BEWARE!
        
        if !isStarted {
            fatalError("You got here without initiating beacons lol")
        }
        
        //This beings the following view code to this window ref -> presentBeaconInNewWindow()
        self.bindedToWindow = window
        
        if !IsTesting.isTesting().loginTesting {
            // Check is user is signed in...
            if let user = FIRAuth.auth()?.currentUser {
                // User is signed in.
                print("SIGNED IN")
                //if not logged in then show the welcome view in storyboard
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyboard.instantiateViewControllerWithIdentifier("MainVC")
                window.rootViewController = mainVC
            } else {
                // No user is signed in.
                print("NOT SIGNED IN")
                //if not logged in then show the welcome view in storyboard
                let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
                let welcomeVC = storyboard.instantiateViewControllerWithIdentifier("WelcomeVC")
                window.rootViewController = welcomeVC
            }
            
        } else {
            //if not logged in then show the welcome view in storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewControllerWithIdentifier("MainVC")
            window.rootViewController = mainVC
            
        }
    }
    
}