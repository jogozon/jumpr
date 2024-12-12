//
//  LocationDataManager.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/10/24.
//

import Foundation
import CoreLocation

class LocationDataManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus?
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           switch manager.authorizationStatus {
           case .authorizedWhenInUse:  // Location services are available.
               authorizationStatus = .authorizedWhenInUse// Insert code here of what should happen when Location services are authorized
               manager.requestLocation()
               break
           case .restricted:
               // Insert code here of what should happen when Location services are NOT authorized
               authorizationStatus = .restricted
               break
           case .denied:  // Location services currently unavailable.
               authorizationStatus = .denied
               break
           case .notDetermined:        // Authorization not determined yet.
               authorizationStatus = .notDetermined
               manager.requestWhenInUseAuthorization()
               break
               
           default:
               break
           }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("handling location updates")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: \(error.localizedDescription)")
    }
}
