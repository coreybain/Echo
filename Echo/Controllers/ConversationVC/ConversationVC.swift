//
//  ConversationVC.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ConversationVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var messageTextViewBottomCon: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageVC.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: self.view.window)
        
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageTextViewBottomCon.constant += keyboardSize.height
                self.view.layoutIfNeeded()
            })
        } else {
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageTextViewBottomCon.constant -= keyboardSize.height - offset.height
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.messageTextViewBottomCon.constant != 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.messageTextViewBottomCon.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

}