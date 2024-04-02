//
//  RideType.swift
//  Uber
//
//  Created by Ashwin Kumar on 15/02/24.
//

import Foundation

enum RideType: Int, Identifiable, CaseIterable{
    var id: Int{
        return rawValue
    }
    case uberGo
    case auto
    case moto
    case premier
    
    
    var noOfPersons: Int{
        switch self {
            case .uberGo:
                return 4
            case .premier:
                return 4
            case .auto:
                return 3
            case .moto:
                return 1

        }
    }
    
    var title: String{
        switch self {
            case .uberGo:
                return "Uber Go"
            case .premier:
                return "Uber Premier"
            case .auto:
                return "Uber Auto"
            case .moto:
                return "Moto"

        }
    }
    
    var description:String{
        switch self {
            case .uberGo:
                return "Affordable, compact rides"
            case .premier:
                return "Quality sedans, top rated drivers"

            case .auto:
                return "No bargaining, doorstep pick-up"

            case .moto:
                return "Affordable motorcycle rides"

        }
        
    }
    var imageName: String{
        switch self {
            case .uberGo:
                return "car-go"
            case .premier:
                return "car-premier"
            case .auto:
                return "auto"
            case .moto:
                return "moto"

        }
    }
    
    
    var baseFare: Double{
        switch self {
            case .uberGo:
                return 90
            case .premier:
                return 120
            case .auto:
                return 70
            case .moto:
                return 40
        }
    }
    
    func computerPrice(for distanceInMeter: Double) -> Double{
        let distanceInKm = distanceInMeter/1000
        
        switch self {
            case .uberGo:
                return distanceInKm * 13 + baseFare
            case .premier:
                return distanceInKm * 20 + baseFare
            case .auto:
                return distanceInKm * 12.5 + baseFare
            case .moto:
                return distanceInKm * 8.5 + baseFare
        }
    }
    
    var vehileImage: String{
        switch self {
            case .uberGo:
                return "swift"
            case .auto:
                return "rickshaw"
            case .moto:
                return "access"
            case .premier:
                return "corolla"
        }
        
    }
    
    var driverName: String{
        switch self {
            case .uberGo:
                return "Raju Gowda"
            case .auto:
                return "Nagraj B"
            case .moto:
                return "Mahesh Kumar"
            case .premier:
                return "Shiva Prasad"
        }
    }
    
    var vehicleBrand: String{
        switch self {
            case .uberGo:
                return "Maruti Swift"
            case .auto:
                return "Bajaj Auto"
            case .moto:
                return "Suzuki Access"
            case .premier:
                return "Toyota Corolla"
        }
    }
}
