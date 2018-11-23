//
//  CoreDataConnection.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/22/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataConnection {
    //MARK : Properties
    public static let instanceShared = CoreDataConnection()
    var managedContext : NSManagedObjectContext!
    
    //MARK : funcs
    func save() -> Bool {
        do {
             try managedContext.save()
            return true
        } catch let err as NSError {
            if err.domain == NSCocoaErrorDomain && (err.code == NSValidationNumberTooLargeError || err.code == NSValidationNumberTooSmallError) {
                print("item value is out of range.\n")
            }
            print("Save data has a error \(err) \n Error Explain : \(err.userInfo)")
        }
        return false
    }
    
    func numberOf<T>(_ request : NSFetchRequest<T>) -> Int {
        do
        {
            return try managedContext.count(for: request)
        }catch let err as NSError {
            print("Get count about \(request.entityName!)) has error \n \(err) \(err.userInfo)")
        }
        return -1
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) -> [T] where T : NSFetchRequestResult {
        var retObj = [T]()
        do {
            try retObj = managedContext.fetch(request)
        } catch let err as NSError {
            print("Error in fetch data \(String(describing: request.entityName)) has error \n \(err) \(err.userInfo)")
        }
        return retObj
    }
}
