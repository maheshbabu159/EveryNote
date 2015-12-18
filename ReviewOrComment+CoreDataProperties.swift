//
//  ReviewOrComment+CoreDataProperties.swift
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

extension ReviewOrComment {

    @NSManaged var comment: String?
    @NSManaged var movie: NSObject?
    @NSManaged var objectId: String?
    @NSManaged var rating: NSNumber?

}
