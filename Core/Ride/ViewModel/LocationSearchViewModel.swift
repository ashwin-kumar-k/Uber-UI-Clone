//
//  LocationSearchViewModel.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import Foundation
import MapKit
import Observation

// Observable object to manage location search and trip details
@Observable
class LocationSearchViewModel: NSObject {
    // MARK: - Properties
    
    // Route information for navigation
    var route: MKRoute?
    
    // Results from location search completion
    var results = [MKLocalSearchCompletion]()
    
    // Selected location coordinates
    var seletedLocationCoordinates: CLLocationCoordinate2D? {
        didSet {
            getDirections() // Calculate directions when location is selected
        }
    }
    
    // Searched places array
    var searchedPlaces = [searchPlace]()
    
    // User location coordinates
    var userLocationCoordinates: CLLocationCoordinate2D?
    
    // Search completer to provide search suggestions
    private let searchCompleter = MKLocalSearchCompleter()
    
    // Flag to control map visibility
    var showMap = false
    
    // Query fragment for pickup location
    var pickupqueryFragment = "" {
        didSet {
            searchCompleter.queryFragment = pickupqueryFragment
        }
    }
    
    // Query fragment for drop-off location
    var dropqueryFragment = "" {
        didSet {
            searchCompleter.queryFragment = dropqueryFragment
        }
    }
    
    // Pickup time for the trip
    var pickUpTime: String?
    
    // Drop-off time for the trip
    var dropOffTime: String?
    
    // State of the ride (e.g., booked, not booked)
    var rideState: BookingState = .notBooked
    
    // Selected ride type
    var selectedRide: RideType = .uberGo
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = ""
    }
    
    // MARK: - Methods
    
    // Select a location from the search results
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            // Handle location search response
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinates = item.placemark.coordinate
            self.seletedLocationCoordinates = coordinates
            
            let place = searchPlace(title: localSearch.title, subtitle: localSearch.subtitle, coordinates: coordinates)
            if self.searchedPlaces.count < 4 {
                self.searchedPlaces.insert(place, at: 0)
            } else {
                self.searchedPlaces.remove(at: self.searchedPlaces.endIndex)
                self.searchedPlaces.insert(place, at: 0)
            }
        }
    }
    
    // Search for the user's location
    func userLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            // Handle location search response
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinates = item.placemark.coordinate
            self.userLocationCoordinates = coordinates
            
            let place = searchPlace(title: localSearch.title, subtitle: localSearch.subtitle, coordinates: coordinates)
            if self.searchedPlaces.count < 4 {
                self.searchedPlaces.insert(place, at: 0)
            } else {
                self.searchedPlaces.remove(at: self.searchedPlaces.endIndex)
                self.searchedPlaces.insert(place, at: 0)
            }
        }
    }
    
    // Perform a location search based on the provided completion
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    // Calculate directions for the trip
    func getDirections() {
        route = nil
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: userLocationCoordinates ?? .userLocation))
        request.destination = MKMapItem(placemark: .init(coordinate: seletedLocationCoordinates ?? .userLocation))
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            self.pickUpandDropTime(with: route?.expectedTravelTime ?? 0.0)
        }
    }
    
    // Calculate pick-up and drop-off times based on expected travel time
    func pickUpandDropTime(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
    // Compute the ride price based on the ride type and trip distance
    func computeRidePrice(forType type: RideType) -> Double {
        guard let source = userLocationCoordinates else { return 0.0 }
        guard let destination = seletedLocationCoordinates else { return 0.0 }
        
        let start = CLLocation(latitude: source.latitude, longitude: source.longitude)
        let stop = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        
        let tripDistance = start.distance(from: stop)
        
        return type.computerPrice(for: tripDistance)
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    // Handle updates to the search completer results
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
