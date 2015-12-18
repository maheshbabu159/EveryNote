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
        if let checked = dictionary.objectForKey("checked") as? NSNumber{
            
            newEntity.checked = checked
        }
        if let objectId = dictionary.objectForKey("objectId") as? String{
            
            newEntity.objectId = objectId
        }
    
        //Save the object
        do {
            
            try newEntity.managedObjectContext?.save()
            
            //Add the notification for the new record
            NotificationsHandler.addNotification(dictionary as AnyObject)

        } catch {
            
            print(error)
        }
        
    }
    class func deleteObject() {
        
        
    }
    class func deleteSelectedObjects(context:NSManagedObjectContext) {
        
        //Predicate
        let predicate = NSPredicate(format: "checked = \(NSNumber(bool: true))")
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, inManagedObjectContext: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        do {
            
            let result = try context.executeFetchRequest(fetchRequest)
            
            for object in result{
                
                context.deleteObject(object as! NSManagedObject)
                
                //Delete the notification for the new record
                NotificationsHandler.cancelNotification((object.valueForKey("objectId") as? String)!)
                
            }
            
        } catch {
            
            print(error as NSError)
        }

    }
    class func updateObject(object:NotesModel, dictionary:AnyObject, context:NSManagedObjectContext) {
        
        //Set propert values
        if let title = dictionary.valueForKey("title"){
            
            object.title = title as? String
        }
        if let note = dictionary.valueForKey("note"){
            
            object.note = note as? String
        }
        if let remainderDate:NSDate  = dictionary.valueForKey("remainderDate") as? NSDate{
            
            object.remainderDate = remainderDate
        }
        if let createdDate:NSDate = dictionary.objectForKey("createdDate") as? NSDate{
            
            object.createdDate = createdDate
        }
        if let checked = dictionary.objectForKey("checked") as? NSNumber{
            
            object.checked = checked
        }
        if let objectId = dictionary.objectForKey("objectId") as? String{
            
            object.objectId = objectId
        }
        
        //Save the object
        do {
            
            try object.managedObjectContext?.save()
            
        } catch {
            
            print(error)
        }

    }
    class func truncateAllObjects(context:NSManagedObjectContext) {
        
        CommonModel.truncateAllObjects(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, context:context)
        
    }
    class func fetchAllObjects(context:NSManagedObjectContext) -> NSArray {
        
        let resultArray = CommonModel.fetchAllObjects(GlobalVariables.CoreDataEntities.NotesModel.rawValue as String, context: context)
        
        return resultArray
    }
}
    