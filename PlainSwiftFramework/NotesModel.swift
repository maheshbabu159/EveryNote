//
//  NotesModel.swift
//  PlainSwiftFramework
//
//  Created by apple on 12/13/15.
//  Copyright © 2015 maheshbabu.somineni. All rights reserved.
//

import Foundation
import CoreData


class NotesModel: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    class func insertObject(dictionary:AnyObject, context:NSManagedObjectContext) {
        
        // Create Managed Object
        let entityDescription = NSEntityDescription.entityForName(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, inManagedObjectContext: context)
        
        //Create new entity
        let newEntity:NotesModel = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: context) as! NotesModel
        
        //Set propert values
        if let title = dictionary.valueForKey("title"){
            
            newEntity.title = title as? String
        }
        if let note = dictionary.valueForKey("note"){
            
            newEntity.note = note as? String
        }
        if let remainderDate:NSDate  = dictionary.valueForKey("remainderDate") as? NSDate{
            
            newEntity.remainderDate = remainderDate
        }
        if let createdDate:NSDate = dictionary.objectForKey("createdDate") as? NSDate{
            
            newEntity.createdDate = createdDate
        }
       
        
        //Save the object
        do {
            
            try newEntity.managedObjectContext?.save()
            
        } catch {
            
            print(error)
        }
        
    }
    class func deleteObject() {
        
        
    }
    class func updateObject() {
        
        
    }
    class func truncateAllObjects(context:NSManagedObjectContext) {
        
        CommonModel.truncateAllObjects(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, context:context)
        
    }
    class func fetchAllObjects(context:NSManagedObjectContext) -> NSArray {
        
        let resultArray = CommonModel.fetchAllObjects(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, context: context)
        
        return resultArray
    }
}
    