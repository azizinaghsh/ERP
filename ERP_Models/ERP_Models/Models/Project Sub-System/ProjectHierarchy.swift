//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectHierarchy: NSObject {
    
    private var currentAllocations : Array<Allocation> = []
    private var allocations : Array<Allocation> = []
    private var requirements : Array<Requirement> = []
    
    override init ()
    {
        
    }
    
    func createRequirement (resource : Resource) -> Requirement
    {
        let requirement = Requirement(resource : resource, project : self)
        requirements.append(requirement)
        return requirement
    }
    
    func allocateResource (allocation : Allocation, requirement : Requirement)
    {
        currentAllocations.append(allocation)
        allocations.append(allocation)
        requirements.removeAtIndex(requirements.indexOf(requirement)!)
        //TODO: notify project manager
    }
    
    func freeResource (allocatedResource : Allocation)
    {
        for allocation in currentAllocations
        {
            if (allocation == allocatedResource)
            {
                allocation.freeResource ()
                currentAllocations.removeAtIndex(allocations.indexOf(allocation)!)
                break
            }
        }
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
}
