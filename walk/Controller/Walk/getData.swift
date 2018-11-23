//
//  getData.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/22/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData

extension WalkController {
    
    func getData (format predicateFormat: String, arguement : String? = nil) -> [Walk] {
        fetch.predicate = NSPredicate(format: predicateFormat , arguement ?? "")
        let retObj = CoreDataConnection.instanceShared.fetch(fetch)
        return retObj
    }
    
    func numberOf(format predicateFormat: String, argument : String? = nil) -> Int {
        fetch.predicate = NSPredicate(format: predicateFormat , argument ?? "")
        let count = CoreDataConnection.instanceShared.numberOf(fetch)
        return count
    }
}
