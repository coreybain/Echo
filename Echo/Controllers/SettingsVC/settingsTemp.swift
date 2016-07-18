//
//  settingsTemp.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SettingsTemp: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func LogoutButtonPressed(sender: AnyObject) {
        do{
            try FIRAuth.auth()!.signOut()
            print("SIGNED OUT")
            EchoMain.echoShared().presentEchoInNewWindow()
        } catch {
            print("ERROR")
        }
    }
}