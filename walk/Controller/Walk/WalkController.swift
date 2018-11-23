//
//  WalkController.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/22/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData

class WalkController : IDBAction{
    typealias entityname =  Walk
    let fetch : NSFetchRequest<Walk>!
    
    init() {
        fetch = NSFetchRequest<Walk>(entityName: "Walk")
    }
    
}
