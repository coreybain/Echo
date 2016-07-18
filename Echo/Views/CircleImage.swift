//
//  CircleImage.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
}

