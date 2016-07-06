//
//  User.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class User: StoredNSObject {
    
    var userPermission : Permission
    var firstName, lastName, username, password : NSString
    
    init (withFirstName firstName : NSString, lastName : NSString, username : NSString, andPassword password : NSString, withEntity entity : UserEntity? = nil)
    {
        userPermission = PermissionCatalog.getInstance().defaultPermission!
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        super.init(UserEntity.self, entity : entity)
    }
    
    func setPermission (permission : Permission)
    {
        self.userPermission = permission
    }
}
