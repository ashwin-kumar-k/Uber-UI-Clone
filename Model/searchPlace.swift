//
//  History.swift
//  Uber
//
//  Created by Ashwin Kumar on 16/02/24.
//

import Foundation
import MapKit
struct searchPlace: Identifiable{
    var id = UUID().uuidString
    var title: String
    var subtitle : String
    var coordinates : CLLocationCoordinate2D
}
