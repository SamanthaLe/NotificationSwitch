//
//  ToSendItem.swift
//  NotificationSwitch
//
//  Created by Samantha Le on 25/08/16.
//  Copyright © 2016 Samantha Le. All rights reserved.
//

import Foundation

struct ToSendItem {
    var title: String
    var deadline: NSDate
    var UUID: String
    
    init(deadline: NSDate, title: String, UUID: String) {
        self.deadline = deadline
        self.title = title
        self.UUID = UUID
    }
    
    var displayThis: Bool {
        // Optionally, you can omit "NSComparisonResult" and just type .OrderDescending
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending) // deadline is earlier than current date
    }
}

