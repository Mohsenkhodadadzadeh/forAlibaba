//
//  insert.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/23/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import Foundation

protocol IDBAction {
    associatedtype entityname
    func insertData(_ value : [String : AnyObject] ) ->Bool
    func update(_ value : [entityname]) -> Bool
    func getData (format predicateFormat: String, arguement : String?) -> [entityname]
    func numberOf(format predicateFormat: String, argument : String?) -> Int
}
