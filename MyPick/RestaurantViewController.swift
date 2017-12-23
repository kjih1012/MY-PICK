//
//  RestaurantViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class RestaurantViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var localLabel: UILabel!
    @IBOutlet var memoText: UITextView!

    var detailRestaurant: NSManagedObject?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let restaurant = detailRestaurant {
            title = restaurant.value(forKey: "title") as? String
            titleLabel.text = restaurant.value(forKey: "title") as? String
            timeLabel.text = restaurant.value(forKey: "time") as? String
            menuLabel.text = restaurant.value(forKey: "menu") as? String
            localLabel.text = restaurant.value(forKey: "local") as? String
            memoText.text = restaurant.value(forKey: "memo") as? String
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView" {
            let dlatitude = detailRestaurant!.value(forKey: "latitude") as? Double
            let dlongitude = detailRestaurant!.value(forKey: "longitude") as? Double
            if let destination = segue.destination as? MapViewController{
                destination.location = RestaurantLocation(latitude: dlatitude!, longitude: dlongitude!)
                destination.mapdetailRestaurant = detailRestaurant
            }
        }
        if segue.identifier == "toMenuView" {
            if let destination = segue.destination as? ImageViewController{
                destination.menuObject = detailRestaurant
            }
        }
    }

    
    @IBAction func share() {
        let text = titleLabel.text
        let textToShare = [ text ]
        // 액티비티 뷰 컨트롤러 셋업
        let activityVC = UIActivityViewController(activityItems: [textToShare as Any] , applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view // 아이패드에서도 동작하도록 팝오버로 설정
        // 제외하고 싶은 타입을 설정 (optional)
        activityVC.excludedActivityTypes = [ UIActivityType.airDrop ]
        // 현재 뷰에서 present
        self.present(activityVC, animated: true, completion: nil)
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
