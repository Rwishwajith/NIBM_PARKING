//
//  LocationController.swift
//  NIBM Parking
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationController: NSObject, CLLocationManagerDelegate,ObservableObject {
    
    @Published var lStatus: CLAuthorizationStatus?
    @Published var lastLoc: CLLocation?
    @Published var isUserWithin1Km = false;
    

    private let location = CLLocationManager()
    override init() {
        super.init()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestAlwaysAuthorization()
        location.startUpdatingLocation()
    }

    
    var isAllowed: Bool {
        guard let status = lStatus else {
            return false
        }
        
        switch status {
        case .notDetermined: return false
        case .authorizedWhenInUse: return true
        case .authorizedAlways: return true
        case .restricted: return false
        case .denied: return false
        default: return false
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.lStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLoc = location
        let nibmLocation = CLLocation(latitude: 2.5, longitude: 5.5)
        isUserWithin1Km = nibmLocation.distance(from: location) <= 1000 ? true : false
    }
}

