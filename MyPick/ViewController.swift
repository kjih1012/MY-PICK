//
//  ViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 3..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var restaurants: [NSManagedObject] = []
    var randomNumber = 0
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        
        let sortDescriptor = NSSortDescriptor (key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            restaurants = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let originalNumbers = Array (0 ... restaurants.count-1)
        for _ in 0 ... restaurants.count {
            randomNumber = Int(arc4random_uniform(UInt32(originalNumbers.count)))
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendRestaurant(_ sender: Any) {
    
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) { // Get the new view controller using segue.destinationViewController. // Pass the selected object to the new view controller.
        if segue.identifier == "toRandomView" {
            if let destination = segue.destination as? RestaurantViewController {
                    destination.detailRestaurant = restaurants[randomNumber]
                }
            }
        }


}

