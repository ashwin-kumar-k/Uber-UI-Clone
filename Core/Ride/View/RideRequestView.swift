//
//  RideRequestView.swift
//  Uber
//
//  Created by Ashwin Kumar on 15/02/24.
//

import SwiftUI

// RideRequestView: A SwiftUI view for requesting a ride and choosing trip options.
struct RideRequestView: View {
    @Environment(LocationSearchViewModel.self) var viewModel // Environment object for location search view model.
    
    var body: some View {
        VStack {
            Spacer() // Spacer to push content to the top.
            VStack(spacing: 0.0) {
                Capsule() // Capsule shape for separator.
                    .frame(width: 49, height: 4) // Size of the capsule.
                    .foregroundColor(Color(.systemGray4)) // Color of the capsule.
                    .padding(.top, 5) // Top padding.
                
                Text("Choose a trip") // Title for trip selection.
                    .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                    .padding(.vertical, 4) // Vertical padding.
                
                Divider() // Divider line.
                
                ScrollView(.vertical, showsIndicators: false) { // Scroll view for ride options.
                    VStack { // Vertical stack for ride cards.
                        ForEach(RideType.allCases) { ride in // Iterate through ride types.
                            RideCard(title: ride.title, // Display ride card for each ride type.
                                     description: ride.description,
                                     persons: ride.noOfPersons,
                                     imageName: ride.imageName,
                                     price: viewModel.computeRidePrice(forType: ride)) // Compute ride price.
                            .onTapGesture { // Handle tap gesture on ride card.
                                withAnimation(.linear(duration: 0.01)) { // Apply animation.
                                    viewModel.selectedRide = ride // Set selected ride.
                                }
                            }
                            .overlay { // Apply overlay to indicate selected ride.
                                if ride == viewModel.selectedRide { // If ride is selected.
                                    RoundedRectangle(cornerRadius: 20) // Rounded rectangle shape.
                                        .stroke(lineWidth: 2) // Border width.
                                        .padding(.horizontal, 10) // Horizontal padding.
                                        .padding(.vertical, 7) // Vertical padding.
                                }
                            }
                        }
                    }
                    .padding(.top) // Top padding.
                }
                .frame(height: 250) // Fixed frame height.
                
                Divider() // Divider line.
                
                HStack { // Horizontal stack for payment details.
                    Image("gpay") // Google Pay icon.
                    Text("9741032662@okhdfcbank") // Payment details.
                        .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                        .fontWeight(.semibold) // Bold font weight.
                    Spacer() // Spacer to push content to the right.
                    Image(systemName: "chevron.right") // Right chevron icon.
                        .font(.caption) // Font size for the icon.
                }
                .padding(.horizontal, 25) // Horizontal padding.
                .padding(.vertical) // Vertical padding.
                
                Button { // Button to choose the selected ride.
                    viewModel.rideState = .waiting // Set ride state to waiting.
                } label: {
                    ZStack { // Stack for button background.
                        RoundedRectangle(cornerRadius: 12) // Rounded rectangle shape.
                            .fill(.black) // Fill color.
                            .frame(maxWidth: .infinity, maxHeight: 55) // Full width and fixed height.
                        
                        Text("Choose \(viewModel.selectedRide.title)") // Button title.
                            .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                            .foregroundStyle(.white) // Text color.
                    }
                }
                .padding(.horizontal) // Horizontal padding.
                .padding(.bottom, 5) // Bottom padding.
                
            }
            .frame(maxWidth: .infinity, maxHeight: 410) // Full width and fixed height.
            .background(.white) // White background color.
        }
    }
}

// RideCard: A SwiftUI view representing a card for displaying ride options.
struct RideCard: View {
    @Environment(LocationSearchViewModel.self) var viewModel // Environment object for location search view model.
    
    var title: String // Title of the ride.
    var description: String // Description of the ride.
    var persons: Int // Number of persons.
    var imageName: String // Name of the image.
    var price: Double // Price of the ride.
    
    var body: some View {
        HStack { // Horizontal stack to arrange content.
            Image(imageName) // Ride image.
            VStack(alignment: .leading, spacing: 5) { // Vertical stack for ride details.
                HStack { // Horizontal stack for ride title and number of persons.
                    Text(title) // Ride title.
                        .font(.custom("UberMove-Medium", size: 20)) // Custom font and size.
                    HStack(spacing: 3.0) { // Horizontal stack for persons icon and count.
                        Image(systemName: "person.fill") // Person icon.
                            .font(.caption) // Font size for the icon.
                        Text("\(persons)") // Number of persons.
                            .font(.custom("UberMove-Regular", size: 12)) // Custom font and size.
                    }
                }
                HStack { // Horizontal stack for drop-off time and distance.
                    Text(viewModel.dropOffTime ?? "") // Drop-off time.
                    Circle() // Circle shape for separator.
                        .fill(.gray) // Fill color.
                        .frame(width: 4) // Fixed width.
                    Text("\(Int.random(in: 1...5)) min away") // Distance.
                    
                }
                .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                
                Text(description) // Ride description.
                    .font(.custom("UberMove-Regular", size: 14)) // Custom font and size.
                    .lineLimit(2) // Limit number of lines.
            }
            Spacer() // Spacer to push content to the right.
            Text(price, format: .currency(code: "INR")) // Ride price.
                .font(.custom("UberMove-Medium", size: 20)) // Custom font and size.
                .padding(.horizontal, 5) // Horizontal padding.
        }
        .padding(.horizontal) // Horizontal padding.
        .padding(.vertical, 12) // Vertical padding.
    }
}

#Preview {
    RideRequestView() // Preview for RideRequestView.
}
