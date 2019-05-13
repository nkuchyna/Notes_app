//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 5/10/19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var info: String?
    @NSManaged public var crDate: Date?
    @NSManaged public var modDate: Date?

}
