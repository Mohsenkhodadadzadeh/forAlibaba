//
//  DataActionExtention.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 11/22/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData

extension ViewController {
    
    func insertSampleData() {
        let count = walkController.numberOf(format: "name != nil")
        if count > 0 {
            return
        }
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            _ = walkController.insertData(dict as! [String : AnyObject])
        }
    }
    
    func populate(walk : Walk) {
        guard let imageData = walk.photoData as Data?,
            let lastWorn = walk.lastWorn as Date? else {
                return
        }
        animalPic.image = UIImage(data: imageData)
        animalNameLable.text = walk.name
        rateLable.text = "Rating : \(walk.rate) / 5"
        timeWornLable.text = " times Worn: \(walk.timesWorn)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        lastWornLable.text = "Last worn : \(dateFormatter.string(from: lastWorn))"
        likeButton.setTitle(walk.favorite ? "Like" : "UnLike", for: .normal)
        self.view.layoutIfNeeded()
    }
}
