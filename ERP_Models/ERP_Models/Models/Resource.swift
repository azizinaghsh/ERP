//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Resource: NSObject {
    
    private var allocations : [Allocation] = []
    private var category : NSString
    var dateAdded : NSString
    var estimatedTimeUse : Int?
    
    init (category : NSString)
    {
        dateAdded = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        self.category = category
    }
    
    func getIsAvailable () -> Bool
    {
        return allocations.isEmpty
    }
    
    func getCategory () -> NSString
    {
        return category
    }
    
    func setCategory (category : String)
    {
        self.category = category
    }
    
    func getEstimatedRelease () -> String?
    {
        if allocations.count == 0
        {
            return nil
        }
        let formatter : NSDateFormatter = NSDateFormatter ()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle

        var bestAllocation : Allocation = allocations[0]
        for allocation in allocations
        {
            if ((formatter.dateFromString(allocation.estimatedReleaseTime)?.isLessThanDate(formatter.dateFromString(bestAllocation.estimatedReleaseTime)!)) != nil)
            {
                bestAllocation = allocation
            }
        }
        return bestAllocation.estimatedReleaseTime
    }
    
    func allocateResource (to projectHierarchy : ProjectHierarchy, withAmount amount : Int? = nil, estimatedUseDuration : Int) -> Allocation?
    {
        if (!getIsAvailable())
        {
            return nil
        }
        else
        {
            let newAllocation = Allocation (resource: self, projectHierarchy: projectHierarchy, amount: amount, estimatedUseDuration: estimatedUseDuration)
            self.estimatedTimeUse = estimatedUseDuration
            allocations.append(newAllocation)
            return newAllocation
        }
    }
    
    func freeResource (fromAllocation allocation : Allocation)
    {
        if let index = allocations.indexOf(allocation)
        {
            allocations.removeAtIndex(index)
        }
    }

}
