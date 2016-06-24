//
//  Allocation.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Allocation: NSObject {
    var allocationTime : (startTime:String, endTime:String?)
    let resource : Resource
    let projectHierarchy : ProjectHierarchy
    init (resource: Resource, _ projectHierarcy : ProjectHierarchy, estimatedRelease : String? = nil)
    {
        self.resource = resource
        self.projectHierarchy = projectHierarcy
        allocationTime.startTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        allocationTime.endTime = estimatedRelease
    }
    
    func freeResource ()
    {
        allocationTime.endTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        resource.freeResource ()        
    }
    
    /*override func isEqual(object: AnyObject?) -> Bool {
        if let allocationFromObject : Allocation = object as? Allocation
        {
            if (allocationFromObject.resource == self.resource &&
            allocationFromObject.projectHierarchy == self.projectHierarchy &&
            allocationFromObject.allocationTime.startTime == self.allocationTime.startTime &&
            allocationFromObject.allocationTime.endTime == self.allocationTime.endTime)
            {
                return true
            }
        }
        return false
    }
    
    override var hash: Int
    {
        return resource.hashValue + 23 * projectHierarchy.hashValue + 23*23 *
    }*/
}
