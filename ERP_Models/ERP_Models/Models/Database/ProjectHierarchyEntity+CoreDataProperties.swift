//
//  ProjectHierarchyEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProjectHierarchyEntity {

    @NSManaged var endDate: String?
    @NSManaged var projectDescription: String?
    @NSManaged var projectName: String?
    @NSManaged var startDate: String?
    @NSManaged var products: NSSet?
    @NSManaged var requirements: NSSet?
    @NSManaged var subProjects: NSSet?
    @NSManaged var totalAllocations: NSSet?

}
