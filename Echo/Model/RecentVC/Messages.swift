//
//  Messages.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class Messages: NSObject {
    
    // MARK: - Private Variables
    
    private var _chatName: String?
    private var _chatImage: String?
    private var _messageText: String?
    private var _messageDate: NSDate?
    private var _hasReadMessage: Bool?
    private var _hasRecievedMessage: Bool?
    private var _people: NSDictionary? 
    
    var chatName: String {
        get {
            if _chatName == nil {
                _chatName = ""
            }
            return _chatName!
        }
    }
    
    var chatImage:String {
        get {
            if _chatImage == nil {
                _chatImage = "default"
            }
            return _chatImage!
        }
    }
    
    var messageText: String {
        get {
            if _messageText == nil {
                _messageText = "Draft Message"
            }
            return _messageText!
        }
    }
    
    var messageDate: NSDate {
        get {
            if _messageDate == nil {
                _messageDate = NSDate()
            }
            return _messageDate!
        }
    }
    
    var hasReadMessage: Bool {
        get {
            if _hasReadMessage == nil {
                _hasReadMessage = false
            }
            return _hasReadMessage!
        }
    }
    
    var hasRecievedMessage: Bool {
        get {
            if _hasRecievedMessage == nil {
                _hasRecievedMessage = false
            }
            return _hasRecievedMessage!
        }
    }
    
    var people: NSDictionary {
        get {
            if _people == nil {
                _people = ["":""]
            }
            return _people!
        }
    }
    
    init(chatName:String, chatImage:String, messageText: String?, messageDate:NSDate, hasReadMessage:Bool, hasRecievedMessage:Bool) {
        self._chatName = chatName
        self._chatImage = chatImage
        self._messageText = messageText
        self._messageDate = messageDate
        self._hasReadMessage = hasReadMessage
        self._hasRecievedMessage = hasRecievedMessage
        
    }
    
    
}