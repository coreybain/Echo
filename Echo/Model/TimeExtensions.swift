//
//  TimeExtentions.swift
//  Echo
//
//  Created by Corey Baines on 16/7/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

class TimeExtensions {
    
    static let te = TimeExtensions()
    
    private let dateFormat = "yyyyMMddHHmmss"
    
    func timeElipsed(seconds: NSTimeInterval) -> String {
        let elapsed: String?
        
        if seconds < 60 {
            elapsed = "just Now"
        } else if (seconds < 60 * 60) {
            let minutes = Int(seconds / 60)
            var minText = "min"
            if minutes > 1 {
                minText = "mins"
            }
            elapsed = "\(minutes) \(minText)"
        } else if (seconds < 24 * 60 * 60) {
            let hours = Int(seconds / (60 * 60))
            var hourText = "hour"
            if hours > 1 {
                hourText = "hours"
            }
            elapsed = "\(hours) \(hourText)"
        } else {
            let days = Int(seconds / (24 * 60 * 60))
            var dayText = "day"
            if days > 1 {
                dayText = "Days"
            }
            elapsed = "\(days) \(dayText)"
        }
        return elapsed!
    }
    
    func dateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter
    }
}