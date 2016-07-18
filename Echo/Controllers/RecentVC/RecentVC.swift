//
//  RecentVC.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RecentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0,0,300,20))
    var recents: [Messages] = []
    var people: [People] = []
    
    override func viewDidLoad() {
        searchBar.placeholder = "Search for people and groups"
        searchBar.searchBarStyle = UISearchBarStyle.Minimal
        var leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        testData()
    }
    
    func testData() {
        let mark = People.init(profileName: "Mark ZuckerBerg", isOnline: true, profileImage: "https://scontent-sea1-1.xx.fbcdn.net/v/t1.0-9/12208495_10102454385528521_4749095086285673716_n.jpg?oh=5828bbf762179e142d2bcb944c304d48&oe=57EA5B5C")
        people.append(mark)
        print(people[0].profileName)
        print(people)
        if people.count == 1 {
            let message = Messages.init(chatName: people[0].profileName, chatImage: people[0].profileImage, messageText: "Hello there corey how are you?", messageDate: NSDate(), hasReadMessage: false, hasRecievedMessage: true)
            print(NSDate().timeIntervalSince1970)
            recents.append(message)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecentVCCell", forIndexPath: indexPath) as! RecentVCCell
        let recent = recents[indexPath.row]
        print(recent.chatName)
        cell.bindData(recent)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let recent = recents[indexPath.row]
        
        performSegueWithIdentifier("SegueConversationVC", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let recent = recents[indexPath.row]
        
        //remove recent from array
        recents.removeAtIndex(indexPath.row)
        
        //Archive recent in firebase
        //archiveChat(recent)
        tableView.reloadData()
    }
    
    // MARK: - Create Chat Room
    func createRoom(users:[String]) {
        if users.count > 2 {
            
        }
        
    }
    
    
    @IBAction func newMessageButtonPressed(sender: AnyObject) {
        print("GO")
        performSegueWithIdentifier("SegueNewMessage", sender: nil)
        
    }
    
}