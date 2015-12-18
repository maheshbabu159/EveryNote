//
//  NotesModel+CoreDataProperties.swift
//  PlainSwiftFramework
//
//  Created by apple on 12/13/15.
//  Copyright © 2015 maheshbabu.somineni. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NotesModel {

    @NSManaged var title: String?
    @NSManaged var remainderDate: NSDate?
    @NSManaged var createdDate: NSDate?
    @NSManaged var note: String?
    @NSManaged var checked: NSNumber?


}
