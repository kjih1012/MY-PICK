//
//  RestaurantLocation.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantLocation: NSObject,MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    init (latitude: Double, longitude: Double) {
        self.coordinate = CLLocationCoordinate2D()
        self.coordinate.latitude = latitude
        self.coordinate.longitude = longitude
    }
}
