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
    var managedContext : NSManagedObjectContext!
    var currentWalk : Walk!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // insert Sample Data If needed
        insertSampleData()
        
        //fill first pet data
        let request = NSFetchRequest<Walk>(entityName: "Walk")
        let firstName = segmentControl.titleForSegment(at: 0)!
        request.predicate = NSPredicate(format: "name == %@", firstName)
        
        do {
            let results = try managedContext.fetch(request)
            currentWalk = results.first!
            
            populate(walk: results.first!)
        }catch let error as NSError {
            print("it has a problem : \(error) , \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedControl(_ sender: Any) {
        
        guard let control = sender as? UISegmentedControl else {
            return
        }
        let selectedValue = control.titleForSegment(at: control.selectedSegmentIndex)
        
        let request = NSFetchRequest<Walk>(entityName: "Walk")
        
        request.predicate = NSPredicate(format: "name == %@", selectedValue!)
        
        do {
            let results = try managedContext.fetch(request)
            currentWalk = results.first
            populate(walk: currentWalk)
        }catch let error as NSError {
            print("it has a problem : \(error) , \(error.userInfo)")
        }
    }
    @IBAction func walkClick() {
        let times = currentWalk.timesWorn
        currentWalk.timesWorn = times + 1
        
        currentWalk.lastWorn = NSDate()
        
        do{
            try managedContext.save()
            populate(walk: currentWalk)
        }catch let err as NSError {
            print("It has error \(err) , \(err.userInfo)")
        }
    }
    @IBAction func favoriteClick() {
        let isFavorite = currentWalk.favorite
        currentWalk.favorite = !isFavorite
        
        do {
            try managedContext.save()
            populate(walk: currentWalk)
            
        }catch let err as NSError {
            print("It has error \(err) , \(err.userInfo)")
        }
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
            do {
                self.currentWalk.rate = rate
                try self.managedContext.save()
                self.populate(walk: self.currentWalk)
            }catch let err as NSError {
                print("It has error \(err) , \(err.userInfo)")
            }
        }
        alert.addAction(cancleAction)
        alert.addAction(saveAction)
        
        present(alert , animated: true)
    }
    
    func insertSampleData() {
        let fetch = NSFetchRequest<Walk>(entityName: "Walk")
        fetch.predicate = NSPredicate(format: "name != nil")
        
        let count = try! managedContext.count(for: fetch)
        
        if count > 0 {
            return
        }
        
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        
        let dataArray = NSArray(contentsOfFile: path!)!
        
        
        
        for dict in dataArray {
            let entity = NSEntityDescription.entity(forEntityName: "Walk", in: managedContext)!
            let walk = Walk(entity: entity , insertInto: managedContext)
            
            let btDict = dict as! [String: AnyObject]
            
            walk.name = btDict["name"] as? String
            walk.favorite = btDict["favorite"] as? Bool ?? false
            walk.timesWorn = btDict["timesWorn"] as? Int32 ?? 0
            walk.lastWorn = btDict["lastWorn"] as? NSDate
            
            let imageName = btDict["imageName"] as? String
            let image = UIImage(named: imageName!)
            let photoData = UIImagePNGRepresentation(image!)!
            walk.photoData = NSData(data: photoData)
            
            walk.rate = btDict["rate"] as? Double ?? 0.0
            
        }
        try! managedContext.save()
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
        
    }
    
}

