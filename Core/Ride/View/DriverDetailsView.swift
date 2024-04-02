//
//  DriverDetailsView.swift
//  Uber
//
//  Created by Ashwin Kumar on 16/02/24.
//

import SwiftUI

// DriverDetailsView: A SwiftUI view for displaying driver details and trip information.
struct DriverDetailsView: View {
    @State var isShown = false // State variable to control sheet presentation.
    @Environment(LocationSearchViewModel.self) var viewModel // Environment object for location search view model.
    
    var body: some View {
        VStack {
            Spacer() // Spacer to push content to the top.
            VStack(spacing: 0.0) {
                Capsule() // Capsule shape for separator.
                    .frame(width: 49, height: 4) // Size of the capsule.
                    .foregroundColor(Color(.systemGray4)) // Color of the capsule.
                    .padding(.top, 5) // Top padding.
                
                HStack { // Horizontal stack for header text and countdown.
                    Text("Meet the driver at \(viewModel.pickupqueryFragment)") // Header text.
                        .font(.custom("UberMove-Medium", size: 18)) // Custom font and size.
                        .multilineTextAlignment(.leading) // Text alignment.
                    Spacer() // Spacer to push content to the right.
                    
                    Rectangle() // Rectangle shape for countdown container.
                        .fill(.black) // Fill color.
                        .frame(width: 55, height: 57) // Size of the rectangle.
                        .overlay { // Overlay for countdown display.
                            VStack { // Vertical stack for countdown.
                                Text("\(Int.random(in: 1...5))") // Random countdown value.
                                    .font(.custom("UberMove-Bold", size: 20)) // Custom font and size.
                                Text("min") // Minutes label.
                            }
                            .foregroundStyle(.white) // Text color.
                        }
                }
                .padding(.horizontal) // Horizontal padding.
                .padding(.vertical, 5) // Vertical padding.
                
                ScrollView(.vertical) { // Scroll view for trip details.
                    VStack { // Vertical stack for trip details.
                        Button { // Button to show trip details.
                            isShown.toggle() // Toggle sheet presentation.
                        } label: {
                            ZStack { // Stack for button background.
                                RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape.
                                    .fill(Color(.systemGray4)) // Fill color.
                                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50) // Full width and fixed height.
                                
                                Text("Trip details") // Button title.
                                    .font(.custom("UberMove-Medium", size: 20)) // Custom font and size.
                                    .foregroundStyle(.black) // Text color.
                            }
                        }
                        .padding(.horizontal) // Horizontal padding.
                        .padding(.vertical, 5) // Vertical padding.
                        
                        Divider() // Divider line.
                        
                        HStack { // Horizontal stack for pin entry.
                            Text("Enter pin to start the trip") // Pin entry instruction.
                                .font(.custom("UberMove-Medium", size: 16)) // Custom font and size.
                            Spacer() // Spacer to push content to the right.
                            HStack(spacing: 5) { // Horizontal stack for pin digits.
                                ForEach(0..<4) { _ in // Iterate through pin digits.
                                    Text("\(Int.random(in: 0...9))") // Random pin digit.
                                        .padding(2) // Padding.
                                        .font(.custom("UberMove-Bold", size: 20)) // Custom font and size.
                                        .foregroundStyle(.white) // Text color.
                                        .frame(width: 25, height: 30) // Fixed size.
                                        .background(.blue) // Background color.
                                }
                            }
                        }
                        .padding(.horizontal) // Horizontal padding.
                        .padding(.vertical, 5) // Vertical padding.
                        
                        Divider() // Divider line.
                        
                        HStack { // Horizontal stack for driver and vehicle details.
                            ZStack { // Stack for driver and vehicle images.
                                Image(viewModel.selectedRide.vehileImage) // Vehicle image.
                                    .resizable() // Resizable image.
                                    .scaledToFit() // Scaled to fit the frame.
                                    .frame(width: 100) // Fixed width.
                                    .offset(x: 20) // Horizontal offset.
                                
                                ZStack { // Stack for driver image.
                                    Circle() // Circle shape.
                                        .fill(.white) // Fill color.
                                        .frame(width: 55) // Fixed size.
                                    Image("user") // Placeholder driver image.
                                        .resizable() // Resizable image.
                                        .scaledToFit() // Scaled to fit the frame.
                                        .frame(width: 50) // Fixed width.
                                        .clipShape(.circle) // Clip to circle shape.
                                }
                                .offset(x: -20) // Horizontal offset.
                            }
                            Spacer() // Spacer to push content to the right.
                            
                            VStack(alignment: .trailing, spacing: 2.0) { // Vertical stack for driver details.
                                Text(viewModel.selectedRide.driverName) // Driver name.
                                    .font(.custom("UberMove-Medium", size: 15)) // Custom font and size.
                                    .foregroundStyle(Color(.systemGray)) // Text color.
                                Text("KA0\(Int.random(in: 1...9))MN\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))") // Vehicle number.
                                    .font(.custom("UberMove-Medium", size: 18)) // Custom font and size.
                                    .padding(.top, 8) // Top padding.
                                HStack { // Horizontal stack for vehicle brand.
                                    Text(viewModel.selectedRide.vehicleBrand) // Vehicle brand.
                                }
                                .font(.custom("UberMove-Medium", size: 12)) // Custom font and size.
                                .foregroundStyle(.gray) // Text color.
                            }
                        }
                        .padding(.horizontal) // Horizontal padding.
                        .padding(.vertical) // Vertical padding.
                        
                        HStack { // Horizontal stack for message and call buttons.
                            Text("Send a message") // Message button text.
                                .padding(5) // Padding.
                                .foregroundStyle(.black) // Text color.
                                .font(.custom("UberMove-Medium", size: 14)) // Custom font and size.
                                .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading) // Full width and fixed height.
                                .padding(.leading) // Leading padding.
                                .background(Color(.systemGray4)) // Background color.
                                .clipShape(.capsule) // Clip to capsule shape.
                            Spacer() // Spacer to push content to the right.
                            Image(systemName: "phone.fill") // Phone call icon.
                                .font(.subheadline) // Font size for the icon.
                                .padding(8) // Padding.
                                .background(Color(.systemGray4)) // Background color.
                                .clipShape(.circle) // Clip to circle shape.
                            Spacer() // Spacer to distribute content evenly.
                            Image(systemName: "sun.max.fill") // Sun icon.
                                .font(.subheadline) // Font size for the icon.
                                .padding(7) // Padding.
                                .background(Color(.systemGray4)) // Background color.
                                .clipShape(.circle) // Clip to circle shape.
                        }
                        .padding(.horizontal) // Horizontal padding.
                        
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 410) // Full width and fixed height.
            .background(.white) // White background color.
        }
        .sheet(isPresented: $isShown, content: { // Sheet presentation for trip details.
            VStack { // Vertical stack for trip details.
                Text("Trip details") // Trip details title.
                    .font(.custom("UberMove-Bold", size: 20)) // Custom font and size.
                    .foregroundStyle(.black) // Text color.
                    .padding(.top) // Top padding.
                Divider() // Divider line.
                
                HStack { // Horizontal stack for drop-off location.
                    Image("location") // Location icon.
                        .resizable() // Resizable image.
                        .scaledToFit() // Scaled to fit the frame.
                        .frame(width: 25) // Fixed width.
                    Text(viewModel.dropqueryFragment) // Drop-off location.
                        .font(.custom("UberMove-Medium", size: 15)) // Custom font and size.
                    Spacer() // Spacer to push content to the right.
                }
                .padding(.vertical, 5) // Vertical padding.
                .padding(.leading) // Leading padding.
                
                Divider() // Divider line.
                    .padding(.leading) // Leading padding.
                
                HStack { // Horizontal stack for trip amount.
                    Image(systemName: "person") // Person icon.
                        .font(.footnote) // Font size for the icon.
                        .frame(width: 25) // Fixed width.
                    VStack { // Vertical stack for trip amount.
                        Text(viewModel.computeRidePrice(forType: viewModel.selectedRide), format: .currency(code: "INR")) // Trip amount.
                            .font(.custom("UberMove-Medium", size: 15)) // Custom font and size.
                        Text("Amount") // Amount label.
                            .font(.footnote) // Font size for the label.
                            .foregroundStyle(.gray) // Text color.
                    }
                    Spacer() // Spacer to push content to the right.
                }
                .padding(.vertical, 5) // Vertical padding.
                .padding(.leading) // Leading padding.
                
                Divider() // Divider line.
                    .padding(.leading, 60) // Leading padding.
                
                HStack { // Horizontal stack for network status warning.
                    Image(systemName: "exclamationmark.circle") // Warning icon.
                        .font(.footnote) // Font size for the icon.
                        .foregroundStyle(.red) // Text color.
                        .frame(width: 20) // Fixed width.
                    Text("We can't reach our network, so the trip total might be outdated") // Warning message.
                        .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                        .frame(width: 250) // Fixed width.
                        .multilineTextAlignment(.leading) // Text alignment.
                        .lineLimit(2) // Limit number of lines.
                    Spacer() // Spacer to push content to the right.
                }
                .padding(.vertical, 5) // Vertical padding.
                .padding(.leading) // Leading padding.
                
                Button { // Button to cancel trip.
                    viewModel.rideState = .notBooked // Set ride state to not booked.
                    viewModel.selectedRide = .uberGo // Reset selected ride.
                } label: {
                    ZStack { // Stack for cancel trip button.
                        RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape.
                            .fill(Color(.systemGray4)) // Fill color.
                            .frame(maxWidth: .infinity, maxHeight: 54) // Full width and fixed height.
                        
                        Text("Cancel trip") // Button title.
                            .font(.custom("UberMove-Medium", size: 20)) // Custom font and size.
                            .foregroundStyle(.red) // Text color.
                    }
                }
                .padding(.horizontal) // Horizontal padding.
                
                Button { // Button to dismiss trip details.
                    isShown.toggle() // Toggle sheet presentation.
                } label: {
                    ZStack { // Stack for done button.
                        RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape.
                            .fill(.black) // Fill color.
                            .frame(maxWidth: .infinity, maxHeight: 54) // Full width and fixed height.
                        
                        Text("Done") // Button title.
                            .font(.custom("UberMove-Medium", size: 20)) // Custom font and size.
                            .foregroundStyle(.white) // Text color.
                    }
                }
                .padding(.horizontal) // Horizontal padding.
                .padding(.bottom, 5) // Bottom padding.
            }
            .presentationDetents([.height(360)]) // Presentation detents for sheet height.
        })
    }
}

#Preview {
    DriverDetailsView() // Preview for DriverDetailsView.
}
