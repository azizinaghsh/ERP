//
//  Module.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Module: InformationResource {
    var creators : Array<HumanResource>
    var maintenances : Array<Maintenance> = []
    var moduleName : NSString
    var moduleDescription : NSString
    
    private var maintenanceIndex : Int = 0
    
    init (moduleName name : NSString, withDescription description : NSString, moduleCreators creators : [HumanResource], category : NSString)
    {
        self.creators = creators as Array<HumanResource>
        self.moduleName = name
        self.moduleDescription = description
        super.init(category: category)
    }
    
    func addMaintenance (withMaintainers maintainers : [HumanResource], description : NSString, andDate date: NSString)
    {
        let newMaintenance = Maintenance(maintainersAre: maintainers, descriptionIs: description, modificationDateIs: date)
        maintenances.append(newMaintenance)
    }
    
    func removeMaintenance (theMaintenance maintenance : Maintenance)
    {
        if let index = maintenances.indexOf(maintenance)
        {
            maintenances.removeAtIndex(index)
        }
    }
}
