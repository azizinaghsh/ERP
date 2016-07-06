//
//  CategoriesEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/6/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class CategoriesEntity : NSManagedObject {
    static func addCategory (category : String) -> CategoriesEntity
    {
        let moc = DataController.getInstance().managedObjectContext
        let newCategory = NSEntityDescription.insertNewObjectForEntityForName(getMyType().0, inManagedObjectContext: moc) as! CategoriesEntity
        newCategory.category = category
        do
        {
            try moc.save()
            return newCategory
        }
        catch
        {
            print ("failed to create resource category")
            fatalError()
        }
    }
    
    static func removeCategory (category : String) -> CategoriesEntity?
    {
        let moc = DataController.getInstance().managedObjectContext
        if let categoriesEntity = ResourceCatalog.getInstance().getResourceEntitiesCategoryByName(resourceCategoriesEntityClassName: getMyType().1, categoryName: category)
        {
            moc.deleteObject(categoriesEntity)
            do
            {
                try moc.save()
            }
            catch
            {
                print (error)
                fatalError("failed to remove category")
            }
            return categoriesEntity
        }
        return nil
    }
    
    class func getMyType () -> (String, String)
    {
        return ("CategoriesEntity", CategoriesEntity.className())
    }
}
