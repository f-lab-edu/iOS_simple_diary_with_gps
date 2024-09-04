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

class GPSServiceImp : NSObject, GPSService {
    
    private var manager : CLLocationManager
    
    override init() {
        manager = CLLocationManager()
        super.init()
        
        manager.delegate = self
    }
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func currentLocation() -> CLLocation {
        return manager.location ?? CLLocation(latitude: 0, longitude: 0)
    }
}

extension GPSServiceImp : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
               case .authorizedAlways, .authorizedWhenInUse:
                   print("GPS: 권한 있음")
               case .restricted, .notDetermined:
                   print("GPS: 아직 선택하지 않음")
               case .denied:
                   print("GPS: 권한 없음")
               default:
                   print("GPS: Default")
               }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
