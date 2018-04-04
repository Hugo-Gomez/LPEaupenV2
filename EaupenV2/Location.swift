//
//  Location.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import UIKit

class Location: Decodable {
    
    var lat: Double?
    var lon: Double?
    
    var description: String {
        guard let lat = lat, let lon = lon else { return "No location"}
        
        return "lat: \(lat), lon: \(lon)"
    }
    
}
