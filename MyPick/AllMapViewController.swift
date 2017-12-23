//
//  AllMapViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class AllMapViewController: UIViewController {

    var restaurants: [NSManagedObject] = []
    var location: RestaurantLocation?
    var locationAnnotation: RestaurantLocation? = nil
    
    @IBOutlet var map: MKMapView!

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
            print("fetch success!")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for i in 0 ..< restaurants.count {
            
            location = RestaurantLocation(latitude: restaurants[i].value(forKey: "latitude") as! Double, longitude: restaurants[i].value(forKey: "longitude") as! Double)
            
            print(restaurants[i].value(forKey: "latitude") as! Double)
            
            map.setRegion(MKCoordinateRegionMake((self.location?.coordinate)!, MKCoordinateSpanMake(1, 1)), animated: true)
            
            // Do any additional setup after loading the view.
            if let annotation = location {
                self.locationAnnotation = annotation
                self.map.addAnnotation(self.locationAnnotation!)
            }
        }

 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
