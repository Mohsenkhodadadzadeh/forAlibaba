//
//  Walk+CoreDataProperties.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/1/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var lastWorn: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var photoData: NSData?
    @NSManaged public var rate: Double
    @NSManaged public var timesWorn: Int32

}
