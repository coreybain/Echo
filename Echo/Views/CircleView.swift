//
//  CircleView.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = frame.size.width / 2
        
    }
    
}