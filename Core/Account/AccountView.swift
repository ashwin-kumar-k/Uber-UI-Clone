//
//  AccountView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// AccountView: A SwiftUI view displaying user account information.
struct AccountView: View {
    var body: some View {
        VStack { // Vertical stack to arrange content.
            HStack { // Horizontal stack for user information.
                VStack(alignment: .leading, spacing: 10.0) { // Vertical stack for text content.
                    Text("Ashwin Kumar") // User's name.
                        .font(.custom("UberMove-Bold", size: 35)) // Custom font and size.
                    HStack { // Horizontal stack for star rating.
                        Image(systemName: "star.fill") // Star icon.
                            .font(.caption) // Font size for the icon.
                        Text("4.78") // User's rating.
                            .font(.custom("UberMove-Medium", size: 15)) // Custom font and size.
                    }
                    .foregroundStyle(.gray) // Text color.
                    .frame(width: 70, height: 30) // Fixed frame size.
                    .background(.ultraThinMaterial) // Background style.
                    .cornerRadius(5) // Corner radius.
                }
                Spacer() // Spacer to push content to the right.
                Image("ashwin") // User's profile image.
                    .resizable() // Allow resizing.
                    .scaledToFit() // Maintain aspect ratio.
                    .frame(width: 65) // Fixed frame size.
                    .clipShape(Circle()) // Clip image to a circle shape.
            }
            .padding(.horizontal, 15) // Horizontal padding.
            
            Spacer() // Spacer to fill remaining space.
        }
    }
}

#Preview {
    AccountView() // Preview for AccountView.
}
