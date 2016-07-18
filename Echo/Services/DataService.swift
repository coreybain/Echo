//
//  DataService.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class DataService {
    static let ds = DataService()
    
    // MARK: - Variables
    
    var peopleDict: [People] = []
    
    // MARK: - Firebase URLS
    
    var ref = FIRDatabase.database().reference()

    
    func createUser(user:String, name:String, devices:[String:String], image:String, chatrooms:[String]?, userClass:String, username:String?, phone:String?, email:String? ) {
        
        var userDataBasic:[String:AnyObject] = ["users": user, "name": name, "devices": devices, "image": image, "userClass": userClass]
        
        if username != nil {
            userDataBasic["username"] = username
        }
        if phone != nil {
            userDataBasic["phone"] = phone
        }
        if email != nil {
            userDataBasic["email"] = email
        }
        if chatrooms != nil {
            userDataBasic["chatrooms"] = chatrooms
        }
        
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(userDataBasic) {(error, ref) -> Void in
         
            if error != nil {
                print("ERROR creating user details \(error?.localizedDescription)")
            }
        }
    }
    
    
    func createRoom(users:[String]) {
        
        let date = TimeExtensions.te.dateFormatter().stringFromDate(NSDate())
        
        let roomData = ["users": [users], "lastMessage": "", "newCounter": 0, "totalCounter": 0, "date": date]
        
        ref.child("chatroom").childByAutoId().setValue(roomData) { (error, ref) -> Void in
            if error != nil {
                print("ERROR creating recent \(error?.localizedDescription)")
            }
        }
    }
    
    
    
}
