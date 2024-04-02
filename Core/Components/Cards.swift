//
//  Cards.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// SmallCard: A SwiftUI view representing a small-sized card with an image and text.
struct SmallCard: View {
    var imageName: String // Image name for the card.
    var name: String // Text content for the card.
    var body: some View {
        VStack {
            ZStack{
                Image("rectangle-small") // Background image for the card.
                Image(imageName) // Image overlaid on the background.
            }
            Text(name) // Text label for the card.
                .font(.custom("UberMove-Medium", size: 15)) // Custom font and size.
        }
    }
}

// MediumCard: A SwiftUI view representing a medium-sized card with an image and text.
struct MediumCard: View {
    var imageName: String // Image name for the card.
    var name: String // Text content for the card.
    var body: some View {
        VStack {
            ZStack{
                Image("rectangle-medium") // Background image for the card.
                Image(imageName) // Image overlaid on the background.
            }
            Text(name) // Text label for the card.
                .font(.custom("UberMove-Medium", size: 17)) // Custom font and size.
        }
    }
}

// BigCard: A SwiftUI view representing a large-sized card with an image and text.
struct BigCard: View {
    var imageName: String // Image name for the card.
    var name: String // Text content for the card.
    var body: some View {
        VStack {
            ZStack{
                Image("rectangle-big") // Background image for the card.
                VStack{
                    Image(imageName) // Image overlaid on the background.
                    Text(name) // Text label for the card.
                        .font(.custom("UberMove-Medium", size: 17)) // Custom font and size.
                }
            }
        }
    }
}
