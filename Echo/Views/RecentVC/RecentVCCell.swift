//
//  RecentVCCell.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class RecentVCCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var photoImage: CircleImage!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var recentMessage: UILabel!
    @IBOutlet weak var statusPhoto: CircleImage!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(recent:Messages) {
        if recent.chatImage != "" {
            
           // photoImage.image = UIImage(named: recent.chatImage)
        }
        profileName.text = recent.chatName
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "h:mm a"
            
        self.updateTime.text = dateformatter.stringFromDate(recent.messageDate)
        
        recentMessage.text = recent.messageText
        
    }
}