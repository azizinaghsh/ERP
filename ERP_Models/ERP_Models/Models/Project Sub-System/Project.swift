//
//  Project.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Project: ProjectHierarchy {
    
    var humanResourceLimit : Int
    var budgetLimit : Int

    
    init (budgetLimit : Int, humanResourceLimit : Int)
    {
        self.humanResourceLimit = humanResourceLimit
        self.budgetLimit = budgetLimit
    }
    
    func getBudget () -> Int
    {
        var budget : Int = 0
        for allocation : Allocation in currentAllocations
        {
            if (allocation.resource is FinancialResource)
            {
                budget += allocation.amount!
            }
        }
        return budget
    }
    
    func getHumanResourcesCount(withRole role : String? = "Any") -> Int
    {
        let humanResources : [Allocation] = super.getResources(HumanResource.self, onlyCurrent: true)
        if (role == "Any")
        {
            return humanResources.count
        }
        var count : Int = 0
        for humanResource in humanResources
        {
            if (humanResource.resource.getCategory() == role)
            {
                count += 1
            }
        }
        return count
    }
    
    
}
