//
//  ViewController.swift
//  walk
//
//  Created by mohsen khodadadzadeh on 10/26/18.
//  Copyright © 2018 mohsen khodadadzadeh. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    //*********************************
    //*********************************
    //        i-swift.ir
    //*********************************
    //*********************************
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var animalPic: UIImageView!
    @IBOutlet weak var rateLable: UILabel!
    @IBOutlet weak var animalNameLable: UILabel!
    @IBOutlet weak var lastWornLable: UILabel!
    @IBOutlet weak var timeWornLable: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    //MARK: -properties
    private var pCurrentWalk : Walk!
    let walkController = WalkController()
    
    var currentWalk : Walk {
        get {
            return pCurrentWalk
        }
        set {
            pCurrentWalk = newValue
            populate(walk: pCurrentWalk)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertSampleData()
         let firstName = segmentControl.titleForSegment(at: 0)!
        guard let firstData = walkController.getData(format: "name == %@", arguement: firstName).first else {
            print("walk Data in viewDidLoad on viewController is load empty")
            return
        }
        currentWalk = firstData
    }

    @IBAction func segmentedControl(_ sender: Any) {
        guard let control = sender as? UISegmentedControl else {
            return
        }
        let selectedValue = control.titleForSegment(at: control.selectedSegmentIndex)
        guard let firstData = walkController.getData(format: "name == %@ ", arguement: selectedValue).first else {
            print("walk Data in segmentedControl on viewController is load empty")
            return
        }
        currentWalk = firstData
    }
    
    @IBAction func walkClick() {
        let updData = currentWalk
        let times = updData.timesWorn
        updData.timesWorn = times + 1
        updData.lastWorn = NSDate()
        currentWalk = walkController.update([updData]) ? updData : currentWalk
    }
    
    @IBAction func favoriteClick() {
        let updData = currentWalk
        let isFavorite = updData.favorite
        updData.favorite = !isFavorite
        currentWalk = walkController.update([updData]) ? updData : currentWalk
    }
    
    @IBAction func Rate(_ sender: Any) {
        let alert = UIAlertController(title: "New Rating", message: "Rate this pet ", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .default, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let alerttextfield = alert.textFields?.first ,
            let ratingString = alerttextfield.text ,
            let rate = Double(ratingString) else {
                return
            }
            let updData = self.currentWalk
            updData.rate = rate
            self.walkController.update([updData]) ? self.currentWalk = updData : self.Rate(self.currentWalk)
        }
        alert.addAction(cancleAction)
        alert.addAction(saveAction)
        present(alert , animated: true)
    }
}

