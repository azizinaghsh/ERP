//
//  ProjectResourceRelationship.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectResourceRelationship: NSObject {
    
    let resource : Resource
    let projectHierarchy : ProjectHierarchy
    let amount : Int?
    var createdAt : String
    var estimatedUseDuration : Int
    
    init(resource : Resource, projectHierarchy : ProjectHierarchy, amount : Int?, estimatedUseDuration : Int)
    {
        self.resource = resource
        self.projectHierarchy = projectHierarchy
        self.amount = amount
        self.estimatedUseDuration = estimatedUseDuration
        createdAt = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
    }
}
