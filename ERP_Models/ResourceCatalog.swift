//
//  ResourceCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ResourceCatalog: NSObject {
    
    private var resources : Array<Resource> = []
    static var instance : ResourceCatalog!
    private var categories : (humanResourceCategories:Array<String>,
    financialResourceCategories:Array<String>,
    informationResourceCategories:Array<String>,
    physicalResourceCategories:Array<String>)
    
    
    override init ()
    {
        categories = (humanResourceCategories :       ["Programmer", "Manager"],
                      financialResourceCategories :   ["Property", "Money", "Sponser"],
                      informationResourceCategories : ["Software Module", "Document"],
                      physicalResourceCategories :    ["Computer","Room","Desk"])
    }
    
    static func getInstance () -> ResourceCatalog
    {
        if (instance == nil)
        {
            instance = ResourceCatalog()
        }
        return instance
    }
    
    func getAllResources () -> Array<Resource>
    {
        return self.resources
    }
    
    func addCategory<T where T:Resource>(type : T.Type, newCategory : String)
    {
        if (type == FinancialResource.self)
        {
            categories.financialResourceCategories.append(newCategory)
        }
        if (type == HumanResource.self)
        {
            categories.humanResourceCategories.append(newCategory)
        }
        if (type == PhysicalResource.self)
        {
            categories.physicalResourceCategories.append(newCategory)
        }
        if (type == InformationResource.self)
        {
            categories.informationResourceCategories.append(newCategory)
        }
    }
    
    func removeCategory<T where T:Resource>(type : T.Type, category : String)
    {
        if (type == FinancialResource.self && categories.financialResourceCategories.contains(category))
        {
            categories.financialResourceCategories.removeAtIndex(categories.financialResourceCategories.indexOf(category)!)
        }
        if (type == HumanResource.self && categories.humanResourceCategories.contains(category))
        {
            categories.financialResourceCategories.removeAtIndex(categories.financialResourceCategories.indexOf(category)!)
        }
        if (type == PhysicalResource.self && categories.physicalResourceCategories.contains(category))
        {
            categories.financialResourceCategories.removeAtIndex(categories.financialResourceCategories.indexOf(category)!)
        }
        if (type == InformationResource.self && categories.informationResourceCategories.contains(category))
        {
            categories.financialResourceCategories.removeAtIndex(categories.financialResourceCategories.indexOf(category)!)
        }
    }
}
