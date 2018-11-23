//
//  Insert.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/22/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData

extension WalkController {

    func insertData(_ value : [String : AnyObject] ) ->Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Walk", in: CoreDataConnection.instanceShared.managedContext)!
        let walk = Walk(entity: entity , insertInto: CoreDataConnection.instanceShared.managedContext)
        walk.name = value["name"] as? String
        walk.favorite = value["favorite"] as? Bool ?? false
        walk.timesWorn = value["timesWorn"] as? Int32 ?? 0
        walk.lastWorn = value["lastWorn"] as? NSDate
        let imageName = value["imageName"] as? String
        let image = UIImage(named: imageName!)
        let photoData = UIImagePNGRepresentation(image!)!
        walk.photoData = NSData(data: photoData)
        walk.rate = value["rate"] as? Double ?? 0.0
        return CoreDataConnection.instanceShared.save()
    }
    
    func update(_ value : [Walk]) -> Bool {
        var retObj = true
        for item in value {
            let fetchResult = getData(format: "name == %@", arguement: item.name!)
            for updateitem in fetchResult {
                updateitem.favorite = item.favorite
                updateitem.lastWorn = item.lastWorn
                updateitem.photoData = item.photoData
                updateitem.rate = item.rate
                updateitem.timesWorn = item.timesWorn
            }
            retObj = retObj ? CoreDataConnection.instanceShared.save() : false
        }
        return retObj
    }
}
