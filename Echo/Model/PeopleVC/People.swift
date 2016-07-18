//
//  PeopleVC.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class People: NSObject {
    
    // MARK: - Private Variables
    
    private var _profileImage: String?
    private var _isOnline: Bool?
    private var _profileName: String?
    
    var profileImage: String {
        get {
            if _profileImage == nil {
                _profileImage = ""
            }
            return _profileImage!
        }
    }
    
    var isOnline: Bool {
        get {
            if _isOnline == nil {
                _isOnline = false
            }
            return _isOnline!
        }
    }
    
    var profileName: String {
        get {
            if _profileName == nil {
                _profileName = ""
            }
            return _profileName!
        }
    }
    
    init(profileName:String, isOnline:Bool, profileImage:String) {
        self._profileName = profileName
        self._isOnline = isOnline
        self._profileImage = profileImage
    }
    
}
