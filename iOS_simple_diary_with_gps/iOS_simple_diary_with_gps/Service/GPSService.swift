//
//  GPSService.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/31/24.
//

import Foundation
import MapKit

protocol GPSService {
    func requestLocationPermission()
    func currentLocation() -> CLLocation
}

class GPSServiceImp : GPSService {
    
    let manager = CLLocationManager()
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func currentLocation() -> CLLocation {
        return manager.location ?? CLLocation(latitude: 0, longitude: 0)
    }
}
