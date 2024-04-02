//
//  WaitingView.swift
//  Uber
//
//  Created by Ashwin Kumar on 16/02/24.
//

import SwiftUI

struct WaitingView: View {
    // State variables
    @State var isShown = false // Indicates whether the trip details sheet is shown
    @State var animationAmount = 0.1 // Controls the animation for the loading indicator
    // Timer to simulate the transition to the booked state after a certain time
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    // Environment object to access data from the LocationSearchViewModel
    @Environment(LocationSearchViewModel.self) var viewModel
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                // Top Capsule for visual separation
                Capsule()
                    .frame(width: 49, height: 4)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.top, 10)
                
                // Text indicating that the app is searching for nearby drivers
                HStack {
                    Text("Finding nearby drivers..")
                        .font(.custom("UberMove-Medium", size: 20))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                // Loading animation represented by a growing and shrinking rectangle
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .overlay {
                        Rectangle()
                            .fill(.black)
                            .scaleEffect(animationAmount) // Controls the scale of the animation
                            .opacity(1.8 - animationAmount) // Controls the opacity of the animation
                            .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount) // Animation configuration
                    }
                    .onAppear{
                        animationAmount = 2 // Start the animation
                    }
                
                // Button to view trip details
                Button{
                    isShown.toggle() // Toggles the visibility of the trip details sheet
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray4))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        
                        Text("Trip details")
                            .font(.custom("UberMove-Medium", size: 20))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,5)
                
                Spacer()
                
                // Placeholder map view to represent the trip location
                HStack{
                    ZStack {
                        Circle()
                            .fill(.blue).opacity(0.25)
                            .frame(width: 100)
                        
                        Image("map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }
                
                Spacer()
                
                Divider()
                
                // Text showing the drop-off time
                Text("Drop-off by \(viewModel.dropOffTime ?? "")")
                    .font(.custom("UberMove-Medium", size: 15))
                    .foregroundStyle(.black)
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: 410) // Limiting the frame size for consistency
            .background(.white) // Setting background color
            
        }
        .onReceive(timer) { _ in // Automatically transitions to booked state after a certain time
            viewModel.rideState = .booked
        }
        .sheet(isPresented: $isShown, content: { // Presents the trip details sheet
            VStack{
                // Title for trip details
                Text("Trip details")
                    .font(.custom("UberMove-Bold", size: 20))
                    .foregroundStyle(.black)
                    .padding(.top)
                Divider()
                
                // Trip details content
                
                // Location information
                HStack{
                    Image("location")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text(viewModel.dropqueryFragment)
                        .font(.custom("UberMove-Medium", size: 15))
                    Spacer()
                }
                .padding(.vertical, 5)
                .padding(.leading)
                
                Divider()
                    .padding(.leading)
                
                // Ride price information
                HStack{
                    Image(systemName: "person")
                        .font(.footnote)
                        .frame(width: 25)
                    VStack {
                        Text(viewModel.computeRidePrice(forType: viewModel.selectedRide), format: .currency(code: "INR"))
                            .font(.custom("UberMove-Medium", size: 15))
                        Text("Amount")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
                .padding(.leading)
                
                
                Divider()
                    .padding(.leading, 60)
                
                // Information about network connectivity and trip total
                HStack{
                    Image(systemName: "exclamationmark.circle")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .frame(width: 20)
                    Text("We can't reach our network, so the trip total might be outdated")
                        .font(.custom("UberMove-Regular", size: 16))
                        .frame(width: 250)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Spacer()
                }
                .padding(.vertical, 5)
                .padding(.leading)
                
                // Button to cancel the trip
                Button{
                    viewModel.rideState = .notBooked
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray4))
                            .frame(maxWidth: .infinity, maxHeight: 54)
                        
                        Text("Cancel trip")
                            .font(.custom("UberMove-Medium", size: 20))
                            .foregroundStyle(.red)
                    }
                }
                .padding(.horizontal)
                
                // Button to dismiss the trip details sheet
                Button{
                    isShown.toggle()
                }label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: 54)
                        
                        Text("Done")
                            .font(.custom("UberMove-Medium", size: 20))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,5)
            }
            .presentationDetents([.height(360)]) // Setting presentation detents for the sheet
        })
    }
}

#Preview {
    WaitingView()
}
