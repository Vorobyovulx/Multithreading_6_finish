//
//  Location.swift
//  GeekWeather
//
//  Created by Mad Brains on 02.07.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var shared = Location()
    
    private init() {}
    
    var lat: Double!
    var lon: Double!
    
    var currentLocationCoordinates: (lat: Double, lon: Double) {
        return (lat: 55.751244, lon: 37.618423)
    }
    
    func set(fromLocation location: CLLocation) {
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
    }
}
