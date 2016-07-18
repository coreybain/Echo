//
//  SignInVC.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInVC: UIViewController {
    
    var dict: NSDictionary!
    
    override func viewDidLoad() {
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
    }
    
    // MARK: - Actions
    
    @IBAction func facebookButtonPressed(sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email", "public_profile", "user_friends"], fromViewController: self, handler: {(facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("ERROR")
            } else if facebookResult.isCancelled {
                print("CANCELLED")
            } else {
                print("YOUR IN")
                print(facebookResult.description)
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,picture.width(480).height(480)"]).startWithCompletionHandler({
                    (connection, result, error : NSError!) -> Void in
                    
                    print(result)
                    self.dict = result as! NSDictionary
                    print(self.dict)
                    print(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                    
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                    FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                        print("WERE IN")
                        if error == nil {
                            
                            DataService.ds.createUser((user?.uid)!, name: (user?.displayName)!, devices: [(EchoMain.echoShared().deviceName):(EchoMain.echoShared().deviceUUID)], image: (user?.photoURL?.absoluteString)!, chatrooms: nil, userClass: "default", username: nil, phone: nil, email: user?.email)
                            
                            let userProfileSet = user?.profileChangeRequest()
                            if let profileImage = self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") {
                                userProfileSet?.photoURL = NSURL(string: profileImage as! String)
                            }
                            if let username = self.dict.objectForKey("name") {
                                userProfileSet?.displayName = username as! String
                            }
                            userProfileSet?.commitChangesWithCompletion { error in
                            
                                if error == nil {
                                    print(user?.photoURL)
                                    EchoMain.echoShared().presentEchoInNewWindow()
                                } else {
                                    print(error?.localizedDescription)
                                }
                            }
                            
                        } else {
                            print(error)
                        }
                    }
                })
                    
            }
        })
        
    }
    
    @IBAction func passwordButtonPressed(sender: AnyObject) {
        print("PASSWORD")
        var tField: UITextField!
        var tField2: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Username"
            tField = textField
        }
        
        func configurationTextField2(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Password"
            tField2 = textField
        }
        
        
        func handleCancel(alertView: UIAlertAction!)
        {
            print("Cancelled !!")
        }
        
        var alert = UIAlertController(title: "Sign In", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(configurationTextField2)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("Done !!")
            print("Item : \(tField.text)")
            print("Item : \(tField2.text)")
            if tField.text != "" && tField2.text != "" {
                FIRAuth.auth()?.createUserWithEmail(tField.text!, password: tField2.text!, completion: { (user, error) in
                    if error == nil {
                        DataService.ds.createUser((user?.uid)!, name: "default", devices: [(EchoMain.echoShared().deviceName):(EchoMain.echoShared().deviceUUID)], image: "default", chatrooms: nil, userClass: "default", username: nil, phone: nil, email: user?.email)
                        
                        EchoMain.echoShared().presentEchoInNewWindow()
                    }
                    print(error?.localizedDescription)
            
                })
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
        
        
    }
    
}