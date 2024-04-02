//
//  RideView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// LocationInputView: A SwiftUI view for inputting ride details and selecting locations.
struct LocationInputView: View {
    @Environment(\.dismiss) var dismiss // Environment object to dismiss the view.
    @State private var viewModel = LocationSearchViewModel() // State variable for location search view model.
    @FocusState var focused: TextFieldState? // Focus state variable for text fields.
    
    var body: some View {
        NavigationStack { // Navigation stack for navigation functionality.
            VStack(spacing: 0.0) { // Vertical stack to arrange content.
                VStack { // Vertical stack for ride planning section.
                    HStack { // Horizontal stack for header and back button.
                        Button {
                            dismiss() // Dismiss the view.
                        } label: {
                            Image("arrow-left") // Back button.
                        }
                        Text("Plan your ride") // Header title.
                            .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                            .frame(maxWidth: .infinity, alignment: .center) // Full width alignment.
                        Image("arrow-left") // Hidden image for alignment.
                            .hidden() // Hide the image.
                    }
                    .padding(.horizontal, 15) // Horizontal padding.
                    
                    ScrollableCards() // Display scrollable cards for ride options.
                    
                    HStack { // Horizontal stack for location text fields and plus button.
                        Image("line") // Horizontal line.
                        VStack { // Vertical stack for text fields.
                            TextField(" Enter pick-up location", text: $viewModel.pickupqueryFragment) // Text field for pick-up location.
                                .frame(maxWidth: .infinity, minHeight: 31) // Full width with minimum height.
                                .background(Color(.systemGray4)) // Background color.
                                .focused($focused, equals: .PickUp) // Apply focus state.
                            
                            TextField(" Where to?", text: $viewModel.dropqueryFragment) // Text field for drop-off location.
                                .frame(maxWidth: .infinity, minHeight: 31) // Full width with minimum height.
                                .background(Color(.systemGray5)) // Background color.
                                .focused($focused, equals: .Drop) // Apply focus state.
                        }
                        .padding(.horizontal, 5) // Horizontal padding.
                        Image("plus-circle") // Plus button.
                    }
                    .padding(.horizontal, 15) // Horizontal padding.
                    .padding(.vertical, 7) // Vertical padding.
                }
                .padding(.bottom) // Bottom padding.
                
                Divider() // Divider line.
                
                List(viewModel.results, id: \.self) { result in // List of search results.
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle) // Display each search result.
                        .onTapGesture {
                            if focused == .PickUp { // If pick-up location is focused.
                                viewModel.userLocation(result) // Set pick-up location.
                                viewModel.pickupqueryFragment = result.title // Set pick-up location text.
                                focused = .Drop // Set focus to drop-off location.
                            } else if focused == .Drop { // If drop-off location is focused.
                                viewModel.selectLocation(result) // Set drop-off location.
                                viewModel.dropqueryFragment = result.title // Set drop-off location text.
                                viewModel.showMap.toggle() // Toggle map view.
                            }
                        }
                }
                .listStyle(PlainListStyle()) // Plain list style.
                
            }
            .fullScreenCover(isPresented: $viewModel.showMap) { // Present map view as full screen cover.
                MapView() // Map view for selecting locations.
                    .environment(viewModel) // Pass environment object.
            }
            
        }
    }
}

// LocationSearchResultCell: A SwiftUI view representing a cell in the search results list.
struct LocationSearchResultCell: View {
    var title: String // Title of the location.
    var subtitle: String // Subtitle of the location.
    var body: some View {
        HStack { // Horizontal stack to arrange content.
            Image("location") // Location icon.
            VStack(alignment: .leading, spacing: 6) { // Vertical stack for title and subtitle.
                Text(title) // Location title.
                    .font(.custom("UberMove-Medium", size: 18)) // Custom font and size.
                    .fontWeight(.semibold) // Bold font weight.
                Text(subtitle) // Location subtitle.
                    .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                    .lineLimit(1) // Limit number of lines.
                    .foregroundStyle(.gray) // Text color.
                    .multilineTextAlignment(.leading) // Text alignment.
            }
            .padding(.leading, 4) // Leading padding.
        }
    }
}

// ScrollableCards: A SwiftUI view representing scrollable cards for ride options.
struct ScrollableCards: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view for cards.
            HStack { // Horizontal stack to arrange cards.
                Image("pickup-card") // Pickup card image.
                Image("oneway-card") // Oneway card image.
                HStack { // Horizontal stack for custom card.
                    Image(systemName: "person.fill") // Person icon.
                    Text("For me") // Card title.
                        .font(.custom("UberMove-Medium", size: 16)) // Custom font and size.
                    Image(systemName: "chevron.down") // Downward arrow icon.
                        .font(.caption) // Font size for the icon.
                        .fontWeight(.semibold) // Bold font weight.
                }
                .frame(width: 120, height: 34) // Fixed frame size.
                .background(Color(.systemGray5)) // Background color.
                .cornerRadius(25) // Corner radius.
            }
            .padding(.horizontal, 15) // Horizontal padding.
        }
    }
}

// SavedPlaces: A SwiftUI view representing a saved places section.
struct SavedPlaces: View {
    var body: some View {
        HStack { // Horizontal stack to arrange content.
            Image("icon-time") // Time icon.
            Text("Search history") // Section title.
                .font(.custom("UberMove-Medium", size: 18)) // Custom font and size.
                .padding(.leading, 5) // Leading padding.
            Spacer() // Spacer to push content to the right.
            Image(systemName: "chevron.right") // Right chevron icon.
                .font(.caption) // Font size for the icon.
        }
        .frame(height: 40) // Fixed height.
        .padding(.horizontal, 20) // Horizontal padding.
        .padding(.vertical, 8) // Vertical padding.
        .foregroundStyle(.black) // Text color.
    }
}

// historyLocation: A SwiftUI view representing a location in search history.
struct historyLocation: View {
    var title: String // Title of the location.
    var subtitle: String // Subtitle of the location.
    var body: some View {
        HStack { // Horizontal stack to arrange content.
            Image("icon-time") // Time icon.
            VStack(alignment: .leading, spacing: 6) { // Vertical stack for title and subtitle.
                Text(title) // Location title.
                    .font(.custom("UberMove-Medium", size: 18)) // Custom font and size.
                    .fontWeight(.semibold) // Bold font weight.
                    .foregroundStyle(.black) // Text color.
                Text(subtitle) // Location subtitle.
                    .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                    .lineLimit(1) // Limit number of lines.
                    .foregroundStyle(.gray) // Text color.
                    .multilineTextAlignment(.leading) // Text alignment.
            }
            .padding(.leading, 10) // Leading padding.
            Spacer() // Spacer to push content to the right.
            Image(systemName: "chevron.right") // Right chevron icon.
                .fontWeight(.semibold) // Bold font weight.
                .foregroundStyle(.gray) // Text color.
        }
    }
}

#Preview {
    LocationInputView() // Preview for LocationInputView.
}
