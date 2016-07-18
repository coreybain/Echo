//
//  NewMessageVC.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreData

class NewMessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var people: [People] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UIView!
    @IBOutlet weak var messageTextViewBottomCon: NSLayoutConstraint!
    
    // MARK: - Variables

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(messageTextView.frame.origin.y)
        self.automaticallyAdjustsScrollViewInsets = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageVC.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewMessageVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: self.view.window)

        
        self.hideKeyboardWhenTappedAround()

        DataService.ds.downloadPeople { (peopleDict) in
            self.people = peopleDict
            self.tableView.reloadData()
        }
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
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewMessageVCCell", forIndexPath: indexPath) as! NewMessageVCCell
        let peoplecell = people[indexPath.row]
        cell.profileName.text = peoplecell.profileName
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let recent = people[indexPath.row]
        
        performSegueWithIdentifier("SegueChatVC", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    @IBAction func sendButtonPressed(sender: AnyObject) {
        
        performSegueWithIdentifier("SegueConversationVCFromNew", sender: nil)
        
    }
    
}