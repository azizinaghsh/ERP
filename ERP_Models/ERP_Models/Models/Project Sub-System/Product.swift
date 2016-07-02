//
//  Product.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Product: NSObject {
    var module : Module
    
    init (withName name : NSString, withDescription description : NSString, productCreatorsAre creators : [HumanResource], category: NSString)
    {
        module = Module (moduleName: name, withDescription: description, moduleCreators: creators, category: category)
    }
    
    func produce ()
    {
        ResourceCatalog.getInstance().addResource(module)
    }
}
