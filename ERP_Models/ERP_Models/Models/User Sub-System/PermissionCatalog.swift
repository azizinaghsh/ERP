//
//  PermissionCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class PermissionCatalog: NSObject {
    
    var permissions : Array<Permission> = []
    private static var instance : PermissionCatalog?
    
    let defaultPermission : Permission
    
    let PERMISSION_CREATE_PROJECT : String = "create_project"
    let PERMISSION_CREATE_USER :String = "create_project"
    let PERMISSION_CREATE_PERMISSION : String = "create_permission"
    let PERMISSION_ALLOCATE_RESOURCE : String = "allocate_permission"
    
    private override init ()
    {
        defaultPermission = Permission ()
        super.init()
    }
    
    static func getInstance () -> PermissionCatalog
    {
        if (instance == nil)
        {
            instance = PermissionCatalog ()
        }
        return instance!
    }
    
    func createPermission () -> Permission
    {
        let newPermission = Permission ()
        permissions.append(newPermission)
        return newPermission
    }
    
    func removePermission (permission : Permission) -> Bool
    {
        if let index = permissions.indexOf(permission)
        {
            permissions.removeAtIndex(index)
            return true
        }
        return false
    }
    
}
