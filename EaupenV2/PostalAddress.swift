//
//  PostalAddress.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import UIKit

class PostalAddress: Decodable {
    
    var address: String?
    var postcode: String?
    var city: String?
    
    var description: String {
        return "\(address ?? "") - \(postcode ?? "") - \(city ?? "")"
    }
    
}
