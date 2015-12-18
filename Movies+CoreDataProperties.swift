//
//  Movies+CoreDataProperties.swift
//  
//
//  Created by apple on 12/11/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movies {

    @NSManaged var cast: String?
    @NSManaged var descrption: String?
    @NSManaged var industry: String?
    @NSManaged var movieLenght: NSNumber?
    @NSManaged var name: String?
    @NSManaged var objectId: String?
    @NSManaged var photo: NSObject?
    @NSManaged var releaseDate: String?

}
