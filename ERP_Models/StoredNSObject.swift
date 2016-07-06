//
//  StoredNSObject.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/5/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class StoredNSObject: NSObject {
    var myEntity : NSManagedObject?
    init<T where T : Entity> (_: T.Type, entity : NSManagedObject?)
    {
        super.init()
        if (entity != nil)
        {
            self.myEntity = entity!
        }
        else
        {
            self.myEntity = T.self.addEntity(self)
        }
    }

}
