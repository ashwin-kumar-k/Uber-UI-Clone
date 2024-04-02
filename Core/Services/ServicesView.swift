//
//  ServicesView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// View to display available services
struct ServicesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // Title: Services
                Text("Services")
                    .font(.custom("UberMove-Bold", size: 35))
                    .frame(maxWidth: .infinity, maxHeight: 25, alignment: .leading)
                    .padding(.leading, 15)
                
                // Subtitle: Go anywhere, Get anything
                Text("Go anywhere, Get anything")
                    .font(.custom("UberMove-Medium", size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                    .padding(.top, 40)
                
                VStack {
                    // Large service cards
                    HStack(spacing: 25) {
                        Spacer()
                        // Ride service card
                        BigCard(imageName: "car", name: "Ride")
                            .overlay {
                                ZStack {
                                    Image("green-card")
                                    Text("Promo")
                                        .font(.custom("UberMove-Medium", size: 13))
                                        .foregroundStyle(.white)
                                }
                                .offset(y: -45)
                            }
                            .padding(.top)
                        
                        // Package service card
                        BigCard(imageName: "package", name: "Package")
                            .overlay {
                                ZStack {
                                    Image("green-card")
                                    Text("Promo")
                                        .font(.custom("UberMove-Medium", size: 13))
                                        .foregroundStyle(.white)
                                }
                                .offset(y: -45)
                            }
                            .padding(.top)
                        
                        Spacer()
                    }
                    
                    // Medium service cards
                    HStack(spacing: 25) {
                        Spacer()
                        // Rentals service card
                        MediumCard(imageName: "car-rental", name: "Rentals")
                        
                        // Moto service card
                        MediumCard(imageName: "moto", name: "Moto")
                        
                        // Auto service card
                        MediumCard(imageName: "auto", name: "Auto")
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

// Preview for ServicesView
#Preview {
    ServicesView()
}
