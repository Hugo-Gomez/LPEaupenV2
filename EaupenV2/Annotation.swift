//
//  Annotation.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let amenity: Amenity
    var title: String?
    
    init?(amenity: Amenity) {
        guard let loc = amenity.loc, let lat = loc.lat, let lon = loc.lon else { return nil }
        
        self.amenity = amenity
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.title = "\(coordinate.latitude) - \(coordinate.longitude)"
        super.init()
    }
    
}
