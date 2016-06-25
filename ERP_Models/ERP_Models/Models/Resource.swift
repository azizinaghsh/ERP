//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Resource: NSObject {
    
    private var isAllocated : Bool
    private var category : String
    var dateAdded : String
    var dateRelease : String?
    var dateEstimatedRelease : String?
    {
        if (estimatedTimeUse != nil)
        {
            //TODO
            
        }
        return nil
    }
    
    
    var estimatedTimeUse : Int?
    
    init (category : String)
    {
        isAllocated = false
        dateAdded = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        self.category = category
    }
    
    func getIsAvailable () -> Bool
    {
        return !isAllocated
    }
    
    func getCategory () -> String
    {
        return category
    }
    
    func setCategory (category : String)
    {
        self.category = category
    }
    
    func getEstimatedRelease() -> String?
    {
        if (getIsAvailable())
        {
            return nil
        }
        else
        {
            return dateEstimatedRelease
        }
    }
    
    func allocateResource (to projectHierarchy : ProjectHierarchy, withAmount amount : Int? = nil, estimatedUseTime : Int) -> Allocation?
    {
        if (!getIsAvailable())
        {
            return nil
        }
        else
        {
            let newAllocation = Allocation (resource: self, projectHierarchy: projectHierarchy, amount: amount, estimatedUseTime: estimatedUseTime)
            self.estimatedTimeUse = estimatedUseTime
            isAllocated = true
            return newAllocation
        }
    }
    
    func freeResource (fromAllocation allocation : Allocation)
    {
        isAllocated = false;
    }

}
