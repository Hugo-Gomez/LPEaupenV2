//
//  AmenityClient.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import CoreLocation
import Alamofire

protocol AmenityClient: class {
    var amenities : [Amenity]? { get set }
}

extension AmenityClient {
    
    func setAmenities(coordinates:  CLLocationCoordinate2D) {
        
        let headers = [
            "Accept" : "application/json"
        ]
        
        let urlParams = [
            "lat": coordinates.latitude,
            "lon": coordinates.longitude,
            "limit" : 50,
            "range" : 1600
        ]
        
        Alamofire.request("http://api.eaupen.net/closest", method : .get, parameters : urlParams, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch(response.result) {
                case .success :
                    guard let data = response.data else { return }
                    
                    self.amenities = try? JSONDecoder().decode([Amenity].self, from: data)
                    
                    if let amenities = self.amenities {
                        print("amenities : \(amenities.map({ item in return item.description }))")
                    }
                    
                case .failure(let error) :
                    print("HTTP FAILURE : \(error.localizedDescription)")
                }
                
        }
    }
    
}
