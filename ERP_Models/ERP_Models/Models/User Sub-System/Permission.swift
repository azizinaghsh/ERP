//
//  Permission.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Permission: NSObject {
    var permittedActions : Set<NSString> = []
    var title : String = ""
    
    func addPermittedAction (actions : NSString...)
    {
        for action in actions
        {
            permittedActions.insert(action)
        }
    }
    
    func removePermittedAction (actions : NSString...) -> Bool
    {
        var result : Bool = true
        for action in actions
        {
            result = result && (true ? permittedActions.remove(action) != nil : false)
        }
        return result
    }
    
    func togglePermittedAction (actions : NSString...)
    {
        for action in actions
        {
            if (getIsPermitted(action))
            {
                removePermittedAction(action)
            }
            else
            {
                addPermittedAction(action)
            }
        }
    }
    
    func getIsPermitted (action : NSString) -> Bool
    {
        return permittedActions.contains(action)
    }
    
    func setPermissionTitle (title : String)
    {
        self.title = title
    }
}




