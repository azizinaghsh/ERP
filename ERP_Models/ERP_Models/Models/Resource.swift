//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Resource: NSObject {
    

    private var allocatedBy : ProjectHierarchy?
    private var allocations : NSMutableArray
    private var category : String
    private var isAvailable : Bool
        {
        get
        {
            if (allocatedBy == nil)
            {
                return false
            }
            else
            {
                return true
            }
        }
    }
    
    override init ()
    {
        allocations = NSMutableArray()
        category = ""
    }
    
    func getIsAvailable () -> Bool
    {
        return isAvailable
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
        if (isAvailable)
        {
            return nil
        }
        else
        {
            return (allocations.lastObject as! Allocation).allocationTime.endTime
        }
    }
    
    func allocateResource (projectHierarchy : ProjectHierarchy) -> Allocation?
    {
        if (!isAvailable)
        {
            return nil
        }
        else
        {
            let newAllocation = Allocation (resource: self, projectHierarchy)
            allocations.addObject(newAllocation)
            allocatedBy = projectHierarchy
            return newAllocation
        }
    }
    
    func freeResource ()
    {
        allocatedBy = nil
    }
    
    func modifyCategory (category : String)
    {
        
    }
}
