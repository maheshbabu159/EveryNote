//
//  MoviesModel.swift
//  PlainSwiftFramework
//
//  Created by apple on 12/12/15.
//  Copyright © 2015 maheshbabu.somineni. All rights reserved.
//

import Foundation
import CoreData


class MoviesModel: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    class func insertObject(context:NSManagedObjectContext) {
        
             
    }
    class func deleteObject() {
        
        
    }
    class func updateObject() {
        
        
    }
    class func truncateAllObject() {
        
        
    }
    class func fetchAllObjects(context:NSManagedObjectContext) -> NSArray {
        
        let resultArray = CommonModel.fetchAllObjects(GlobalVariables.CoreDataEntities.Movies.rawValue as String, context: context)
        
        return resultArray
    }
}
