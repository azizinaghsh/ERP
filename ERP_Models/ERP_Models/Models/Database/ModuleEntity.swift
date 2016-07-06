//
//  ModuleEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class ModuleEntity: ResourceEntity {
    
    override func setupEntity(object: NSObject) {
        let module = object as! Module
        self.name = module.name as String
        self.moduleDescription = module.moduleDescription as String
        self.dateAdded = module.dateAdded as String
        self.myCategory = (ResourceCatalog.getInstance().getResourceEntitiesCategoryByName(resourceCategoriesEntityClassName: ModuleCategoriesEntity.className(), categoryName: module.getCategory() as String) as? ModuleCategoriesEntity)
        for humanResource in module.creators
        {
            self.creators?.setByAddingObject(ResourceCatalog.getInstance().FindResourceEntity(HumanResourceEntity.self, name: humanResource.name)[0])
        }
    }
    
    override class func getMyType () -> String
    {
        return "Module"
    }
}
