//
//  Amenity.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import UIKit

class Amenity: Decodable {
    
    var _id: String?
    var source: String?
    var licence: String?
    var name: String?
    var amenity: String?
    var updated: Int?
    var point_type: String?
    var loc: Location?
    var postal_address: PostalAddress?
    var dist: Double?
    
    var description: String {
        guard let lat = loc?.lat, let lon = loc?.lon else {
            return "No location"
        }
        return "lat: \(lat), lon: \(lon)"
    }
    
}

