//
//  Allocation.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Allocation: ProjectResourceRelationship {
    var releaseTime : NSString?
    var isCurrent : Bool = true
    var estimatedReleaseTime : NSString
        {
        get
        {
            let formatter : NSDateFormatter = NSDateFormatter ()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let date : NSDate = formatter.dateFromString(createdAt)!
            return formatter.stringFromDate(date.addDays(estimatedUseDuration))
        }
    }
    
    
    func freeResource ()
    {
        if (isCurrent)
        {
            releaseTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
            resource.freeResource (fromAllocation: self)
            isCurrent = false
        }
    }
    
    func getReleaseTime () -> NSString
    {
        if isCurrent
        {
            return estimatedReleaseTime
        }
        return releaseTime!
    }
}
