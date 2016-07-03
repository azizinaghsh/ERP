//
//  UserCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class UserCatalog: NSObject {
    
    var users : Array<User> = []
    
    static var instance : UserCatalog?
    
    var currentUser : User?
    
    private override init ()
    {
        super.init()
    }
    
    static func getInstance () -> UserCatalog
    {
        if (instance == nil)
        {
            instance = UserCatalog ()
        }
        return instance!
    }
    
    func login (username : NSString, password : NSString) -> Bool
    {
        if let user = FindUser(username)
        {
            if user.password == password
            {
                currentUser = user
                return true
            }
        }
        return false
    }
    
    func logout ()
    {
        currentUser = nil
    }
    
    func addUser (withFirstName firstName : NSString, lastName : NSString, andUserName username : NSString, withPassword password : NSString) -> User?
    {
        if (FindUser(username) != nil)
        {
            let newUser = User (withFirstName: firstName, lastName: lastName, username: username, andPassword: password)
            users.append(newUser)
            return newUser
        }
        return nil
    }
    
    func removeUser (user : User) -> Bool
    {
        if let index = users.indexOf(user)
        {
            users.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func FindUser (username : NSString) -> User?
    {
        for user in users
        {
            if user.username == username
            {
                return user
            }
        }
        return nil
    }
}
