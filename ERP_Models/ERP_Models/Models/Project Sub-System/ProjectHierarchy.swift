//
//  Resource.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectHierarchy: NSObject {
    
    var currentAllocations : Array<Allocation> = []
    var totalAllocations : Array<Allocation> = []
    var products : Array<Product> = []
    var subProjects : [ProjectHierarchy] = []
    var startDate, endDate : NSString?
    var projectName : NSString
    var projectDescription : NSString = ""
    
    private var requirements : Array<Requirement> = []
    
    init (withName name : NSString, dateCreated : NSString? = nil)
    {
        if (dateCreated == nil)
        {
            self.startDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        }
        else
        {
            self.startDate = dateCreated!
        }
        self.projectName = name
        super.init()
    }

    
    func createProduct (withName name : NSString, withDescription description : NSString, productCreatorsAre creators : [HumanResource], category: NSString)
    {
        let newProduct = Product(withName: name, withDescription: description, productCreatorsAre: creators, category: category)
        products.append(newProduct)
    }
    
    func createRequirement (forResource resource : Resource, withAmount amount : Int?, estimatedToBeUsed estimate : Int) -> Requirement
    {
        let requirement = Requirement(resource : resource, projectHierarchy : self, amount: amount, estimatedUseDuration: estimate)
        requirements.append(requirement)
        return requirement
    }
    
    func addSubSystem (withName name : NSString) -> ProjectHierarchy
    {
        let newSubProject = ProjectHierarchy (withName: name)
        subProjects.append(newSubProject)
        return newSubProject
    }
    
    func allocateResource (allocation : Allocation, requirement : Requirement)
    {
        currentAllocations.append(allocation)
        totalAllocations.append(allocation)
        
        //TODO: notify project manager
    }
    
    func freeResource (allocatedResource : Allocation)
    {
        allocatedResource.freeResource ()
        currentAllocations.removeAtIndex(currentAllocations.indexOf(allocatedResource)!)
    }
    
    func getResources<T where T:Resource> (type : T.Type, onlyCurrent : Bool = false) -> [Allocation]
    {
        var requestedAllocations : [Allocation] = []
        for allocation in totalAllocations
        {
            if (allocation.resource is T)
            {
                if (!onlyCurrent || currentAllocations.contains(allocation))
                {
                    requestedAllocations.append(allocation)
                }
            }
        }
        return requestedAllocations
    }
    
    
    func checkRequirements ()
    {
        var toBeRemoved : [Requirement] = []
        for requirement in requirements
        {
            if (requirement.tryRequirement())
            {
                toBeRemoved.append(requirement)
            }
        }
        for requirement in toBeRemoved
        {
            requirements.removeAtIndex(requirements.indexOf(requirement)!)
        }
    }
    
    
    func endProject ()
    {
        endDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        requirements.removeAll()
        for product in products
        {
            product.produce()
        }
        for allocation in currentAllocations
        {
            allocation.freeResource()
        }
        for subProject in subProjects
        {
            subProject.endProject()
        }
    }
}
