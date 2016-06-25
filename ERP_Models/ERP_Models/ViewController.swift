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
        let newProject : Project = ProjectCatalog.getInstance().addProject(3,humanResourceLimit: 3)
        
        let newProject2 : Project = ProjectCatalog.getInstance().addProject(3,humanResourceLimit: 3)
        
        let newHumanResource : HumanResource = HumanResource(totalAmount: 10,category: (ResourceCatalog.getInstance().getCategories(HumanResource.className())[0]))
        let newModule : Module = Module(moduleName: "RigidBody", withDescription: "RigidBody simulation of a 3D object", moduleCreators: [], category: "Module")
        
        newProject.createRequirement(forResource: newHumanResource, withAmount: 4, estimatedToBeUsed: 10)
        newProject.createRequirement(forResource: newModule, withAmount: nil, estimatedToBeUsed: 10)
        newProject2.createRequirement(forResource: newHumanResource, withAmount: 7,estimatedToBeUsed: 10)
        newProject2.createRequirement(forResource: newModule, withAmount: nil,estimatedToBeUsed: 10)

        newProject.checkRequirements()
        newProject2.checkRequirements()
        
        
        
        
        print (newProject.getHumanResourcesCount())
        print (newProject.getResources(Module.self).count)
        print (newProject2.getHumanResourcesCount())
        print (newProject2.getResources(Module.self).count)        
        print (newHumanResource.remainedAmount)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

