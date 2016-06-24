//
//  Requirements.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Requirement: NSObject {

    private let resource : Resource
    private let project : ProjectHierarchy
    private let createdAt : String
    
    init(resource : Resource, project : ProjectHierarchy)
    {
        self.resource = resource
        self.project = project
        createdAt = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    }
    
    func tryRequirement () -> Bool
    {
        if let allocation = resource.allocateResource(project)
        {
            project.allocateResource(allocation, requirement: self)
            return true
        }
        return false
    }
}
