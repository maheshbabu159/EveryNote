//
//  CommonOperations.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by maheshbabu.somineni on 12/11/15.
//  Copyright © 2015 CHENHAO. All rights reserved.
//

import UIKit
import CoreData

class CommonModel: NSObject {

  
    class func fetchAllObjects(entityName:String, context:NSManagedObjectContext) -> NSArray {
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        //Execute request
        do {
            
            let result = try context.executeFetchRequest(fetchRequest)
            return result
            
        } catch {
            
            print(error as NSError)
            return NSArray()
        }
    }
    class func truncateAllObjects(entityName:String, context:NSManagedObjectContext) {
        
        //Fetch object
        let fetchRequest = NSFetchRequest()
        
        //Fetch request properties
        fetchRequest.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        fetchRequest.includesPropertyValues = false
        
        //Execute request
        do {
            if let resultsArray = try context.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
               
                for object in resultsArray {
                    
                    context.deleteObject(object)
                    
                    //Delete the notification for the new record
                    NotificationsHandler.cancelNotification((object.valueForKey("objectId") as? String)!)
                }
                
                try context.save()
            }
        } catch {
            
            print(error as NSError)
        }
    }
    
    class func deleteObject(entityName:String, key:String, value:String,context:NSManagedObjectContext) {
        
        //Predicate
        let predicate = NSPredicate(format: "\(key) = '\(value)'")
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        do {
            
            let result = try context.executeFetchRequest(fetchRequest)
            
            for object in result{
                
                context.deleteObject(object as! NSManagedObject)
            }
            
        } catch {
            
            print(error as NSError)
        }
    }
}
