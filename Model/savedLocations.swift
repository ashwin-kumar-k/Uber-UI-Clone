//
//  SavedPlaces.swift
//  Uber
//
//  Created by Ashwin Kumar on 15/02/24.
//

import Foundation
import MapKit

enum savedLocations{
    case Home
    
    var coordinates : CLLocationCoordinate2D{
        switch self {
            case .Home:
                return CLLocationCoordinate2D(latitude: 12.972442, longitude: 77.580643)
        }
                
    }
}
