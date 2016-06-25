//
//  ProjectCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectCatalog: NSObject {
    private var projects : Array<Project>
    private static var instance : ProjectCatalog!
    private var categories : Array<String>
    
    
    
    private override init ()
    {
        projects = Array<Project>()
        categories = ["Web-based Project"]
    }
    
    static func getInstance () -> ProjectCatalog
    {
        if (instance == nil)
        {
            instance = ProjectCatalog ()
        }
        return instance
    }
    
    func getProjects () -> [Project]
    {
        return projects as [Project]
    }
    
    func addCategory (newCategory : String)
    {
        categories.append(newCategory)
    }
    
    func removeCategory (category : String) -> Bool
    {
        if let index : Int = categories.indexOf(category)
        {
            categories.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func addProject (budgetLimit : Int, humanResourceLimit : Int) -> Project
    {
        let newProject = Project (budgetLimit: budgetLimit, humanResourceLimit: humanResourceLimit)
        projects.append(newProject)
        return newProject
    }
}
