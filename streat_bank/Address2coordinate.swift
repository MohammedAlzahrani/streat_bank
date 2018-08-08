//
//  Address2coordinate.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 28/09/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import Foundation
import CoreLocation
class Address2coordinate {
    func getCoordinate(address: String, completionHandler: (content: CLLocationCoordinate2D) -> ()){
        
        
        func forwardGeocoding(address: String) {
            CLGeocoder().geocodeAddressString(address) { (placemarks, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coordinate = location!.coordinate
                    
                    
                    completionHandler(content: coordinate)
                    print("\nlat: \(coordinate.latitude), long: \(coordinate.longitude)")
                    
                }
            }
            
        }
        forwardGeocoding(address)
        
    }
}