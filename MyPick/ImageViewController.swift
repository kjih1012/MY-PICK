//
//  ImageViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ImageViewController: UIViewController {

    var menuObject: NSManagedObject?
    
    @IBOutlet var menuImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let menu = menuObject {
            if let imageData = menu.value(forKey: "image") as? NSData   {
                if let image = UIImage(data:imageData as Data) {
                    menuImage.image = image
                }
            }
            self.title = menu.value(forKey: "title") as? String
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
