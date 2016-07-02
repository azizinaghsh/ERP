//
//  Allocation.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Allocation: ProjectResourceRelationship {
    var releaseTime : String?
    var isCurrent : Bool = true
    var estimatedReleaseTime : String
        {
        get
        {
            let formatter : NSDateFormatter = NSDateFormatter ()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .ShortStyle
            let date : NSDate = formatter.dateFromString(createdAt)!
            return formatter.stringFromDate(date.addDays(estimatedUseDuration))
        }
    }
    
    
    func freeResource ()
    {
        isCurrent = true
        releaseTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        resource.freeResource (fromAllocation: self)
    }
}
