//
//  QuantitativeResource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class QuantitativeResource: Resource {
    var totalAmount : Int
    var allocatedAmount : Int
    var remainedAmount : Int
        {
        get {
            return totalAmount - allocatedAmount
        }
    }
    
    init (name : NSString, totalAmount : Int, category : String)
    {   
        self.totalAmount = totalAmount
        allocatedAmount = 0
        super.init(category: category, name : name)
    }
    
    override func allocateResource(to projectHierarchy: ProjectHierarchy, withAmount amount: Int?, estimatedUseDuration : Int) -> Allocation?
    {
        let requiredAmount : Int = amount!
        if (requiredAmount <= remainedAmount)
        {
            if let newAllocation : Allocation = super.allocateResource(to: projectHierarchy, withAmount: amount, estimatedUseDuration: estimatedUseDuration)
            {
                allocatedAmount += requiredAmount
                return newAllocation
            }
        }
        return nil
    }
    
    override func freeResource(fromAllocation allocation : Allocation) {
        allocatedAmount -= allocation.amount!
        super.freeResource(fromAllocation: allocation)
    }
    
    override func getIsAvailable() -> Bool
    {
        if (remainedAmount == 0)
        {
            return false;
        }
        return true
        
    }
}
