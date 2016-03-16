//
//  ViewController.swift
//  GPS Tracker App
//
//  Created by Sekai Lab BD on 3/16/16.
//  Copyright © 2016 Sekai Lab BD. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: LOcation Properties
    
    let locationManager = CLLocationManager()
    
    //MARK: UI Properties
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var positionFinderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        positionLabel.text = "find your position hitting the button"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: CLLocation Manager delegate methods
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        positionLabel.text = error.description
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("I am here in the manager")
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks,error) in
            print("in completion handler")
            if let error = error {
                self.positionLabel.text = error.localizedDescription
            } else if placemarks?.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.positionLabel.text = pm.locality
                
            }
        })
        
    }
    
    //MARK: position Finder method
    @IBAction func positionFinder(sender: AnyObject) {
        print("button Pressed")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }


}

