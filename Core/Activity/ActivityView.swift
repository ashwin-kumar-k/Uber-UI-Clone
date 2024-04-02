//
//  ActivityView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// ActivityView: A SwiftUI view displaying user activity including upcoming and past trips.
struct ActivityView: View {
    var body: some View {
        NavigationStack { // Navigation stack for navigation functionality.
            ScrollView(.vertical, showsIndicators: false) { // Vertical scroll view for content.
                VStack { // Vertical stack to arrange content.
                    Text("Upcoming") // Title for upcoming trips section.
                        .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                        .fontWeight(.semibold) // Bold font weight.
                        .frame(maxWidth: .infinity, maxHeight: 25, alignment: .leading) // Full width and limited height with leading alignment.
                        .padding(.leading, 15) // Left padding.
                        .padding(.top, 25) // Top padding.
                    
                    HStack { // Horizontal stack for upcoming trips content.
                        VStack(alignment: .leading, spacing: 8) { // Vertical stack to arrange text content.
                            Text("You have no upcoming trips") // Placeholder text for no upcoming trips.
                                .multilineTextAlignment(.leading) // Multiline text alignment.
                                .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                            HStack(spacing: 1.0) { // Horizontal stack for secondary text and arrow icon.
                                Text("Reserve your trip") // Secondary text for reserving a trip.
                                    .font(.custom("UberMove-Regular", size: 16)) // Custom font and size.
                                    .foregroundStyle(.gray) // Text color.
                                Image(systemName: "arrow.right") // Arrow icon.
                                    .foregroundStyle(.gray) // Icon color.
                            }
                        }
                        Image("reserve") // Placeholder image for reserving a trip.
                    }
                    .frame(width: 350, height: 90) // Fixed frame size for the upcoming trips section.
                    .overlay { // Overlay to add stroke around the content.
                        RoundedRectangle(cornerRadius: 10) // Rounded rectangle shape.
                            .stroke(lineWidth: 1).fill(.gray) // Stroke style and color.
                    }
                    .padding(.vertical) // Vertical padding.
                    
                    Text("Past") // Title for past trips section.
                        .font(.custom("UberMove-Medium", size: 22)) // Custom font and size.
                        .frame(maxWidth: .infinity, alignment: .leading) // Full width with leading alignment.
                        .padding(.leading, 15) // Left padding.
                    
                    Spacer() // Spacer to fill remaining space.
                }
                .toolbar { // Toolbar for navigation bar customization.
                    ToolbarItem(placement: .topBarLeading) { // Toolbar item for leading position.
                        Text("Activity") // Title for the activity view.
                            .font(.custom("UberMove-Bold", size: 35)) // Custom font and size.
                            .frame(maxWidth: .infinity, maxHeight: 25, alignment: .leading) // Full width with leading alignment.
                    }
                }
            }
        }
    }
}

#Preview {
    ActivityView() // Preview for ActivityView.
}
