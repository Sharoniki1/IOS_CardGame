//
//  LocationManager.swift
//  cardGameCode
//
//  Created by Student7 on 20/06/2023.
//

import Foundation
import MapKit

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    @Published var status: Bool = false
    @Published var isUserOnLeftSide: Bool = false
    @Published var stringName: String = ""
    
    private let locationManager = CLLocationManager()
    private let dividingPointLongitude: CLLocationDegrees = 34.817549168324334
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
                         [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters:
                                            5000, longitudinalMeters: 5000)
        self.status = true
        if location.coordinate.longitude < dividingPointLongitude {
            self.isUserOnLeftSide = true;
        }
        else{
            self.isUserOnLeftSide = false;
            
        }
        locationManager.stopUpdatingLocation()
    }
}
