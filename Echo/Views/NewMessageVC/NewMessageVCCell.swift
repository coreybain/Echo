//
//  NewMessageVCCell.swift
//  Echo
//
//  Created by Corey Baines on 17/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class NewMessageVCCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileImage: CircleView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(people:People) {
        
    }
}