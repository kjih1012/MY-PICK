//
//  MapViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet var map: MKMapView!
    
    @IBOutlet var mapTitleLabel: UILabel!
    @IBOutlet var mapLocalLabel: UILabel!
    
    var location: RestaurantLocation?
    var locationAnnotation: RestaurantLocation? = nil
    var mapdetailRestaurant: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        map.setRegion(MKCoordinateRegionMake((self.location?.coordinate)!, MKCoordinateSpanMake(0.007, 0.007)), animated: true)
        
        
        if let annotation = locationAnnotation {
            self.map.removeAnnotation(annotation)
        }
        
        if let annotation = location {
            self.locationAnnotation = annotation
            self.map.addAnnotation(self.locationAnnotation!)
            self.locationAnnotation?.title = mapdetailRestaurant?.value(forKey: "local") as? String
        }

        if let restaurant = mapdetailRestaurant {
            title = restaurant.value(forKey: "title") as? String
            mapTitleLabel.text = restaurant.value(forKey: "title") as? String
            mapLocalLabel.text = restaurant.value(forKey: "local") as? String            
        }
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
