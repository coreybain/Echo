//
//  DataServicePeople.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension DataService {
    
    func downloadPeople(complete: [People] -> ()) {
        let user = FIRAuth.auth()?.currentUser?.uid
        peopleDict.removeAll()
        print(user)
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            for data in snapshot.children {
                let firebaseUser = (data.value["users"] as! String)
                if firebaseUser != user! {
                    print("HELLO\(user)")
                    
                    if let profileName = data.value["name"] {
                        if let profileImage = data.value["image"] {
                            if let isOnline = data.value["isOnline"] {
                                var isOnlineBool:Bool = false
                                if (isOnline as! String) == "True" {
                                    isOnlineBool = true
                                }
                                
                                let peopleCell = People.init(profileName: (profileName as! String), isOnline: isOnlineBool, profileImage: (profileImage as! String))
                                self.peopleDict.append(peopleCell)
                                
                            }
                        }
                    }
                    
                }
            }
            if self.peopleDict.count > 0 {
                complete(self.peopleDict)
            }
        
        })
        
    }
    
}