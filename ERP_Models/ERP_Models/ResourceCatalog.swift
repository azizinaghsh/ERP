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

    private var categories : [String : [String]]
    
    
    private override init ()
    {
        categories = [HumanResource.className(): ["Programmer", "Manager"],
                      FinancialResource.className() : ["Property", "Money", "Sponser"],
                      InformationResource.className() : ["Software Module", "Document"],
                      PhysicalResource.className() : ["PC","Room","Desk","iMac"]]
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
    
    
    func addCategory(resourceClassName : String, newCategory : String)
    {
        categories[resourceClassName]?.append(newCategory)
    }
    
    func removeCategory(resourceClassName : String, category : String) -> Bool
    {
        if let index : Int = categories[resourceClassName]?.indexOf((category))
        {
            categories[resourceClassName]?.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func getCategories (resourceClassName : String) -> [String]
    {
        return categories[resourceClassName]!
    }
}
