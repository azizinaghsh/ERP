//
//  ViewController.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    override func viewDidLoad() {
        let newProject : Project = ProjectCatalog.getInstance().addProject(withName: "ERP", budgetLimit: 3, humanResourceLimit: 3, isManagedBy: nil)
        
        
        let newProject2 : Project = ProjectCatalog.getInstance().addProject(withName: "ERP2", budgetLimit: 3, humanResourceLimit: 3, isManagedBy: nil)
        
        let newHumanResource : HumanResource = HumanResource(name : "hadi",totalAmount: 10,category: (ResourceCatalog.getInstance().getCategories(HumanResource.className())[0]))
        let newModule : Module = Module(moduleName: "RigidBody", withDescription: "RigidBody simulation of a 3D object", moduleCreators: [], category: "Module")
        
        newProject.createRequirement(forResource: newHumanResource, withAmount: 4, estimatedToBeUsed: 20)
        newProject.createRequirement(forResource: newModule, withAmount: nil, estimatedToBeUsed: 5)
        newProject2.createRequirement(forResource: newHumanResource, withAmount: 3, estimatedToBeUsed: 22)
        newProject2.createRequirement(forResource: newModule, withAmount: nil, estimatedToBeUsed: 3)
        newProject.checkRequirements()
        newProject2.checkRequirements()
        
        let moc = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
        /*let moduleEntity = NSEntityDescription.insertNewObjectForEntityForName("Module", inManagedObjectContext: moc) as! ModuleEntity
        
        let humanResourceCategory = NSEntityDescription.insertNewObjectForEntityForName("HumanResourceCategories", inManagedObjectContext: moc) as! HumanResourceCategoriesEntity
        
        let moduleCategory = NSEntityDescription.insertNewObjectForEntityForName("InformationResourceCategories", inManagedObjectContext: moc) as! InformationResourceCategoriesEntity
        
        moduleCategory.category = "Flat UI"
        
        humanResourceCategory.category = "Graphics Programmer"
        
        let humanEntity = NSEntityDescription.insertNewObjectForEntityForName("HumanResource", inManagedObjectContext: moc) as! HumanResourceEntity
        humanEntity.myCategory = humanResourceCategory
        humanEntity.name = "Hossein Azizi"
        humanEntity.dateAdded = NSDateFormatter.localizedStringFromDate(NSDate (), dateStyle: .ShortStyle, timeStyle: .NoStyle)
        humanEntity.allocatedAmount = 2
        humanEntity.totalAmount = 7
        
        moduleEntity.creators = [humanEntity]
        moduleEntity.moduleDescription = "Flat UI Is Awsome"
        moduleEntity.myCategory = moduleCategory
        moduleEntity.name = "Flat Button"
        moduleEntity.dateAdded = NSDateFormatter.localizedStringFromDate(NSDate (), dateStyle: .ShortStyle, timeStyle: .NoStyle)
        
        do {
            try
                moc.save()
        } catch {
            print (error)
        }*/
        
        let employeesFetch = NSFetchRequest(entityName: "Module")

        do {
            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [ModuleEntity]
            for emp in fetchedEmployees
            {
                for human in emp.creators!
                {
                    print ((human as! HumanResourceEntity).name!)
                }
            }
        } catch {
            print ("can't get")
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        print (newProject.getHumanResourcesCount())
        print (newProject.getResources(Module.self).count)
        print (newProject2.getHumanResourcesCount())
        print (newProject2.getResources(Module.self).count)
        print (newHumanResource.remainedAmount)
        print (newHumanResource.getEstimatedRelease()!)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

