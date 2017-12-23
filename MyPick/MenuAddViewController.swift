//
//  MenuAddViewController.swift
//  MyPick
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MobileCoreServices

class MenuAddViewController: UIViewController,UITextFieldDelegate, CLLocationManagerDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet var titleText: UITextField!
    @IBOutlet var timeText: UITextField!
    @IBOutlet var menuText: UITextField!
    @IBOutlet var localText: UITextField!
    @IBOutlet var memoText: UITextView!
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    let locationManager: CLLocationManager = CLLocationManager()
    
    let picker = UIImagePickerController()
    var menuImage:UIImage! = nil

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations[locations.count-1]
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        let findLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(findLocation, completionHandler: {(placemarks, error) in if let address:[CLPlacemark] = placemarks {
            if let name: String = address.last?.name {
                print(name)
                self.localText.text = name
            }
            }
        })

    }

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생",
                                              message: "위치서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        }
        else {
            let alert = UIAlertController(title: "오류 발생", message: "위치서비스 제공 불가",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
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
    @IBAction func getLocal(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func addList(_ sender: UIButton) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Restaurant", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(titleText.text, forKey: "title")
        object.setValue(timeText.text, forKey: "time")
        object.setValue(menuText.text, forKey: "menu")
        object.setValue(localText.text, forKey: "local")
        object.setValue(memoText.text, forKey: "memo")
        object.setValue(latitude, forKey: "latitude")
        object.setValue(longitude, forKey: "longitude")
        
        let imageData = UIImageJPEGRepresentation(menuImage, 1)
        object.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        _ = UIAlertController(title:"메뉴 등록",message: "메뉴가 정삭적으로 등록되었습니다.",preferredStyle: UIAlertControllerStyle.alert)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
        
        
    }
    
    
    @IBAction func addMenuBoard(_ sender: UIButton) {
        let alert =  UIAlertController(title: "Add menu", message: "select how to add menu board", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "album", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "camera", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            menuImage = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
