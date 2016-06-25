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
    var isCurrent : Bool = false
    
    func freeResource ()
    {
        releaseTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        resource.freeResource (fromAllocation: self)
    }
}
