//
//  InformationResource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class InformationResource: Resource {
    override init<T where T : ResourceEntity>(category: NSString, name: NSString, type: T.Type, entity: NSManagedObject? = nil) {
        super.init(category: category, name: name, type: type, entity: entity)
    }
}
