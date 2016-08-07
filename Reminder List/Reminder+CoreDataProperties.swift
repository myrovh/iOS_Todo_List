//
//  Reminder+CoreDataProperties.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 7/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Reminder {

    @NSManaged var dTitle: String?
    @NSManaged var dDescription: String?
    @NSManaged var dDate: NSDate?
    @NSManaged var dComplete: NSNumber?
    @NSManaged var owner: List?

}
