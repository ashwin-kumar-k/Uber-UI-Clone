//
//  MapView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI
import MapKit

// MapView: A SwiftUI view displaying a map with annotations for user locations and trip details.
struct MapView: View {
    @Environment(LocationSearchViewModel.self) var viewModel // Environment object for location search view model.
    @State var showsheet = false // State variable to control presentation of modal sheet.
    
    var body: some View {
        Map { // Map view to display map and annotations.
            // Annotation for user's current location.
            Annotation("", coordinate: viewModel.userLocationCoordinates ?? .userLocation) {
                // Annotation view for user's current location.
                ZStack {
                    // Circle indicating user's location.
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                    // Small circle within the circle for styling.
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(.white)
                    // Stack to display pickup time and location details.
                    HStack(spacing: 0.0) {
                        Text(viewModel.pickUpTime ?? "") // Pickup time.
                            .padding(2)
                            .font(.custom("UberMove-Medium", size: 13)) // Custom font and size.
                            .foregroundStyle(.white) // Text color.
                            .multilineTextAlignment(.center) // Text alignment.
                            .frame(width: 40, height: 40) // Fixed frame size.
                            .background(.black) // Background color.
                        // Stack to display pickup location details.
                        HStack(spacing: 0.0) {
                            Text(viewModel.pickupqueryFragment) // Pickup location.
                                .padding(.leading, 5)
                                .font(.custom("UberMove-Medium", size: 13)) // Custom font and size.
                                .foregroundStyle(.black) // Text color.
                                .multilineTextAlignment(.leading) // Text alignment.
                                .lineLimit(2) // Limit number of lines.
                                .frame(width: 80, height: 40, alignment: .leading) // Fixed frame size.
                            Image(systemName: "chevron.right") // Chevron icon for navigation.
                                .font(.subheadline) // Font size for the icon.
                                .frame(width: 20, height: 40, alignment: .center) // Fixed frame size.
                        }
                        .frame(width: 100, height: 40) // Fixed frame size.
                        .background(.white) // Background color.
                    }
                    .offset(x: 70, y: -30) // Offset to position the stack.
                }
            }
            .annotationTitles(.hidden) // Hide annotation titles.
            
            // Annotation for selected location.
            Annotation("", coordinate: viewModel.seletedLocationCoordinates ?? .userLocation) {
                // Annotation view for selected location.
                ZStack {
                    // Rectangle indicating selected location.
                    Rectangle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                    // Small rectangle within the rectangle for styling.
                    Rectangle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(.white)
                    // Stack to display drop-off time and location details.
                    HStack(spacing: 0.0) {
                        Text(viewModel.dropOffTime ?? "") // Drop-off time.
                            .padding(2)
                            .font(.custom("UberMove-Medium", size: 13)) // Custom font and size.
                            .foregroundStyle(.white) // Text color.
                            .multilineTextAlignment(.center) // Text alignment.
                            .frame(width: 40, height: 40) // Fixed frame size.
                            .background(.black) // Background color.
                        // Stack to display drop-off location details.
                        HStack(spacing: 0.0) {
                            Text(viewModel.dropqueryFragment) // Drop-off location.
                                .padding(.leading, 5)
                                .font(.custom("UberMove-Medium", size: 13)) // Custom font and size.
                                .foregroundStyle(.black) // Text color.
                                .multilineTextAlignment(.leading) // Text alignment.
                                .lineLimit(2) // Limit number of lines.
                                .frame(width: 80, height: 40, alignment: .leading) // Fixed frame size.
                            Image(systemName: "chevron.right") // Chevron icon for navigation.
                                .font(.subheadline) // Font size for the icon.
                                .frame(width: 20, height: 40, alignment: .center) // Fixed frame size.
                        }
                        .frame(width: 100, height: 40) // Fixed frame size.
                        .background(.white) // Background color.
                    }
                    .offset(x: 70, y: -30) // Offset to position the stack.
                }
            }
            .annotationTitles(.hidden) // Hide annotation titles.
            
            // Display route polyline if available.
            if let route = viewModel.route {
                MapPolyline(route.polyline) // Polyline representing the route.
                    .stroke(.black, lineWidth: 3) // Stroke style and width.
            }
        }
        .sheet(isPresented: $showsheet) { // Present modal sheet based on state variable.
            if viewModel.rideState == .notBooked { // If ride is not booked, display ride request view.
                RideRequestView()
                    .presentationDetents([.height(410)]) // Set presentation detents.
            } else if viewModel.rideState == .waiting { // If waiting for ride, display waiting view.
                WaitingView()
                    .environment(viewModel) // Pass environment object.
                    .presentationDetents([.height(410)]) // Set presentation detents.
            } else if viewModel.rideState == .booked { // If ride is booked, display driver details view.
                DriverDetailsView()
                    .environment(viewModel) // Pass environment object.
                    .presentationDetents([.height(410)]) // Set presentation detents.
            }
        }
        .overlay { // Overlay for additional UI elements.
            VStack { // Vertical stack to arrange content.
                ExitButton() // Exit button to dismiss the modal sheet.
                    .shadow(radius: 10) // Apply shadow effect.
                Spacer() // Spacer to fill remaining space.
                // Button to trigger modal sheet presentation.
                ZStack {
                    Button {
                        showsheet.toggle() // Toggle modal sheet presentation.
                    } label: {
                        RoundedRectangle(cornerRadius: 12) // Rounded rectangle shape.
                            .fill(.black) // Fill color.
                            .frame(width: 350, height: 55) // Fixed frame size.
                    }
                    Text(viewModel.rideState == .notBooked ? "Choose a trip" : "Ride Details") // Button text based on ride state.
                        .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                        .foregroundStyle(.white) // Text color.
                }
                .padding(.bottom, 5) // Bottom padding.
            }
        }
        .mapControls { // Map controls.
            MapCompass() // Display compass control.
        }
    }
}

// Extension to provide default user location.
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 12.97194, longitude: 77.59369) // Default user location coordinates.
    }
}

// Extension to provide default user region.
extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: .userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000) // Default user region.
    }
}

// ExitButton: A SwiftUI view representing an exit button to dismiss the modal sheet.
struct ExitButton: View {
    @Environment(\.dismiss) var dismiss // Environment object to dismiss the view.
    var body: some View {
        Button {
            dismiss() // Dismiss the modal sheet.
        } label: {
            Image("arrow-left") // Image for the exit button.
                .frame(width: 47, height: 47) // Fixed frame size.
                .background(.white) // Background color.
                .clipShape(.circle) // Clip to circle shape.
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Full width with leading alignment.
        .padding(.leading, 15) // Left padding.
    }
}

#Preview {
    MapView() // Preview for MapView.
}
