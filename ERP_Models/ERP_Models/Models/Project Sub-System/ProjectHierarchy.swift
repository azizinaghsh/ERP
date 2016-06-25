//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectHierarchy: NSObject {
    
    var currentAllocations : Array<Allocation> = []
    var allocations : Array<Allocation> = []
    private var requirements : Array<Requirement> = []
    var startDate, endDate : String?
    
    init (dateCreated : String? = nil)
    {
        if (dateCreated == nil)
        {
            self.startDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        }
        else
        {
            self.startDate = dateCreated!
        }
    }
    
    func createRequirement (forResource resource : Resource, withAmount amount : Int?, estimatedToBeUsed estimate:Int) -> Requirement
    {
        let requirement = Requirement(resource : resource, projectHierarchy : self, amount: amount, estimatedUseTime: estimate)
        requirements.append(requirement)
        return requirement
    }
    
    func allocateResource (allocation : Allocation, requirement : Requirement)
    {
        currentAllocations.append(allocation)
        allocations.append(allocation)
        
        //TODO: notify project manager
    }
    
    func freeResource (allocatedResource : Allocation)
    {
        allocatedResource.freeResource ()
        currentAllocations.removeAtIndex(currentAllocations.indexOf(allocatedResource)!)
    }
    
    func getResources<T where T:Resource> (type : T.Type, onlyCurrent : Bool = false) -> [Allocation]
    {
        var requestedAllocations : [Allocation] = []
        for allocation in allocations
        {
            if (allocation.resource is T)
            {
                if (!onlyCurrent || currentAllocations.contains(allocation))
                {
                    requestedAllocations.append(allocation)
                }
            }
        }
        return requestedAllocations
    }
    
    func checkRequirements ()
    {
        var toBeRemoved : [Requirement] = []
        for requirement in requirements
        {
            if (requirement.tryRequirement())
            {
                toBeRemoved.append(requirement)
            }
        }
        for requirement in toBeRemoved
        {
            requirements.removeAtIndex(requirements.indexOf(requirement)!)
        }
    }
}
