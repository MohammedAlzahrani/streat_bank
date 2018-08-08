//
//  mapViewController.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 28/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//
// this class is used to display a location on map

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController {
    var lat = 2.3
    var long = 3.2
    var locationTitle = ""

    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
        print(lat + long)
        let location = CLLocationCoordinate2DMake(lat, long)
        
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let regoin = MKCoordinateRegion(center: location, span: span)
        map.setRegion(regoin, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = locationTitle
        
        
        map.addAnnotation(annotation)
       
    }
    
}
