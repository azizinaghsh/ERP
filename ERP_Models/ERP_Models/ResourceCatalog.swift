//
//  ResourceCatalog.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class ResourceCatalog: NSObject {
    
    private var resources : Array<Resource> = []
    private var resourceEntities : Array<ResourceEntity> = []
    static var instance : ResourceCatalog!
    
    private var categories : [String : [String]]
    private var categoriesEntities : [String : [CategoriesEntity]]
    private var entitiesFetched : Bool = false
    private var resourceClassNameToResourceCatEntityClassNameMapping : [String : String]
    
    private override init ()
    {
        categories = [HumanResource.className(): [],
                      FinancialResource.className() : [],
                      Module.className() : [],
                      PhysicalResource.className() : []]
        categoriesEntities = [HumanResourceCategoriesEntity.className(): [],
                      FinancialResourceCategoriesEntity.className() : [],
                      ModuleCategoriesEntity.className() : [],
                      PhysicalResourceCategoriesEntity.className() : []]
        
        resourceClassNameToResourceCatEntityClassNameMapping = [HumanResource.className():HumanResourceCategoriesEntity.className(), PhysicalResource.className():PhysicalResourceCategoriesEntity.className(), FinancialResource.className():FinancialResourceCategoriesEntity.className(), Module.className():ModuleCategoriesEntity.className()]
        super.init()
    }
    
    static func getInstance () -> ResourceCatalog
    {
        if (instance == nil)
        {
            instance = ResourceCatalog()
        }
        if (!instance!.entitiesFetched)
        {
            instance!.fetchResourcesFromDatabase()
            instance.entitiesFetched = true
        }
        return instance
    }
    
    func addResource (resource : Resource)
    {
        resources.append(resource)
    }
    
    func removeResource (resource : Resource) -> Bool
    {
        if let index = resources.indexOf(resource)
        {
            resources.removeAtIndex(index)
            return true
        }
        return false
    }
    
    
    func getAllResources () -> Array<Resource>
    {
        return self.resources
    }
    
    
    func addCategory<T: CategoriesEntity>(resourceClassName : String, newCategory : String, entityType: T.Type)
    {
        categories[resourceClassName]?.append(newCategory)
        categoriesEntities[resourceClassNameToResourceCatEntityClassNameMapping[resourceClassName]!]?.append(T.addCategory(newCategory))
    }
    
    func removeCategory<T: CategoriesEntity>(resourceClassName : String, category : String, entityType: T.Type) -> Bool
    {
        if let index : Int = categories[resourceClassName]?.indexOf((category))
        {
            categories[resourceClassName]?.removeAtIndex(index)
            if let removedEntity = T.removeCategory(category)
            {
                if let index : Int = categoriesEntities[resourceClassNameToResourceCatEntityClassNameMapping[resourceClassName]!]?.indexOf(removedEntity)
                {
                    categoriesEntities[resourceClassNameToResourceCatEntityClassNameMapping[resourceClassName]!]?.removeAtIndex(index)
                }
            }
            return true
        }
        return false
    }
    
    func getCategories (resourceClassName : String) -> [String]
    {
        return categories[resourceClassName]!
    }
    
    func getResourceEntitiesCategories (resourceCategoriesEntityClassName entityClassName : String) -> [CategoriesEntity]?
    {
        return categoriesEntities[entityClassName]!
    }
    
    func getResourceEntitiesCategoryByName (resourceCategoriesEntityClassName entityClassName: String, categoryName: String) -> CategoriesEntity?
    {
        for categoryEntity in categoriesEntities[entityClassName]!
        {
            if (categoryEntity.category! == categoryName)
            {
                return categoryEntity
            }
        }
        return nil
    }
    
    func FindResource<T where T : Resource> (type : T.Type, name : NSString? = nil) -> [Resource]
    {
        var result : [Resource] = []
        for resource in resources
        {
            if (resource is T && (resource.name == name || name == nil))
            {
                result.append(resource)
            }
            
        }
        return result
    }
    
    func FindResourceEntity<T where T : ResourceEntity> (type : T.Type, name : NSString? = nil) -> [ResourceEntity]
    {
        var result : [ResourceEntity] = []
        for resource in resourceEntities
        {
            if (resource is T && (resource.name == name || name == nil))
            {
                result.append(resource)
            }
        }
        return result
    }
    
    func fetchResourcesFromDatabase ()
    {
        fetchResourcesPerType(PhysicalResource.className(), resourceName: "PhysicalResource")
        fetchResourcesPerType(HumanResource.className(), resourceName: "HumanResource")
        fetchResourcesPerType(FinancialResource.className(), resourceName: "FinancialResource")
        fetchResourcesPerType(Module.className(), resourceName: "Module")
    }
    
    private func fetchResourcesPerType (resourceClassName : String, resourceName : NSString)
    {
        let moc = DataController.getInstance().managedObjectContext
        let resourceCategoryFetch = NSFetchRequest(entityName: (resourceName as String) + "Categories")
        let resourceFetch = NSFetchRequest (entityName: resourceName as String)
        
        do
        {
            let resourceCategories = try moc.executeFetchRequest(resourceCategoryFetch) as! [CategoriesEntity]
            let newResourceEntities = try moc.executeFetchRequest(resourceFetch) as! [ResourceEntity]
            for cat in resourceCategories
            {
                categories[resourceClassName]?.append(cat.category!)
                categoriesEntities[resourceClassNameToResourceCatEntityClassNameMapping[resourceClassName]!]?.append(cat)
            }
            for resourceEntity in newResourceEntities
            {
                var newResource : Resource? = nil
                switch resourceClassName
                {
                case HumanResource.className():
                    let humanEntity = resourceEntity as! HumanResourceEntity
                    newResource = HumanResource(name: humanEntity.name!, totalAmount: humanEntity.totalAmount as! Int, category: humanEntity.myCategory!.category!, entity: humanEntity)
                    (newResource as! HumanResource).allocatedAmount = (humanEntity.allocatedAmount! as Int)
                case FinancialResource.className():
                    let financialEntity = resourceEntity as! FinancialResourceEntity
                    newResource = FinancialResource(name: resourceEntity.name!, totalAmount: financialEntity.totalAmount as! Int, category: financialEntity.myCategory!.category!, entity: financialEntity)
                    (newResource as! FinancialResource).allocatedAmount = (financialEntity.allocatedAmount! as Int)
                case Module.className():
                    newResource = fetchModule(resourceEntity)
                case PhysicalResource.className():
                    let physicalEntity = resourceEntity as! PhysicalResourceEntity
                    newResource = PhysicalResource(category: physicalEntity.myCategory!.category!, name: physicalEntity.name!, physicalResourceCode: physicalEntity.resourceCode!, roomNumber: physicalEntity.roomNumber as! Int, entity: physicalEntity)
                default: print ("invalid resource")
                }
                newResource?.dateAdded = resourceEntity.dateAdded!
                addResource(newResource!)
                resourceEntities.append(resourceEntity)
            }
        }
        catch
        {
            print (error)
            fatalError("Coudn't get resources")
        }
    }
    
    
    private func fetchModule (resourceEntity : ResourceEntity) -> Resource?
    {
        let maintenanceFetch = NSFetchRequest(entityName: "Maintenance")
        let moc = DataController.getInstance().managedObjectContext
        do
        {
            let module = resourceEntity as! ModuleEntity
            let newResource = Module (moduleName: module.name!, withDescription: module.description, moduleCreators: [], category: module.myCategory!.category!, entity: module)
            let humanResources = FindResource(HumanResource.self)
            for humanResource in humanResources
            {
                for creatorEntity in module.creators!
                {
                    if (creatorEntity.name == humanResource.name)
                    {
                        newResource.creators.append(humanResource as! HumanResource)
                    }
                }
            }
            let maintenanceEntities = try moc.executeFetchRequest(maintenanceFetch) as! [MaintenanceEntity]
            for maintenanceEntity in maintenanceEntities
            {
                if (maintenanceEntity.myModule!.name == module.name)
                {
                    let newMaintenance = Maintenance(title: maintenanceEntity.title!, maintainersAre: [], descriptionIs: maintenanceEntity.describe!, modificationDateIs: maintenanceEntity.modificationDate!, entity: maintenanceEntity)
                    newResource.maintenances.append(newMaintenance)
                    for humanResource in humanResources
                    {
                        for maintainer in maintenanceEntity.maintainers!
                        {
                            if (maintainer.name == humanResource.name)
                            {
                                newMaintenance.maintainers.append(humanResource as! HumanResource)
                            }
                        }
                    }
                }
            }
            return newResource
        }
        catch
        {
            print (error)
            fatalError("Failed to fetch maintenances")
        }
        return nil
        
    }

}
