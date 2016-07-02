//
//  Requirements.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Requirement: ProjectResourceRelationship {    
    
    func tryRequirement () -> Bool
    {
        if let allocation = resource.allocateResource(to: projectHierarchy, withAmount: amount, estimatedUseDuration: self.estimatedUseDuration)
        {
            projectHierarchy.allocateResource(allocation, requirement: self)
            return true
        }
        return false
    }
}
