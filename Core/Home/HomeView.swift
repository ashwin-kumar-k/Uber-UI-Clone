//
//  ContentView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// Main view representing the home screen
struct HomeView: View {
    @State var showRide = false // State variable to control showing the ride view    
    var body: some View {
        NavigationStack { // Custom navigation stack for navigation control
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    SearchButton(showRide: $showRide) // Search button to trigger ride view
                    
                    // Placeholder for recent locations (commented out due to lack of viewModel)
                    RecentLocation(title: "Home", subtitle: "8nd Main Rd, Rajajinagar, Bengaluru")
                    
                    SuggestionHeader() // Header for suggestions section
                    
                    SuggestionList() // List of suggestions
                    
                    SaveWithUber() // Section showing ways to save with Uber
                    
                    UseUber() // Section showing more ways to use Uber
                }
            }
            .fullScreenCover(isPresented: $showRide, content: {
                LocationInputView() // Full screen modal for location input
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    UberLogo() // Uber logo in the toolbar
                }
            }
        }
    }
}

// Preview for HomeView
#Preview {
    HomeView()
}

// View for the Uber logo
struct UberLogo: View {
    var body: some View {
        Text("Uber")
            .font(.custom("UberMove-Bold", size: 35))
            .frame(maxWidth:.infinity, maxHeight: 25 , alignment: .leading)
    }
}

// Button for initiating a search
struct SearchButton: View {
    @Binding var showRide: Bool // Binding to control showing the ride view
    
    var body: some View {
        Button {
            showRide.toggle() // Toggles the state to show the ride view
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.systemGray4))
                    .frame(maxWidth: .infinity, minHeight: 53)
                    .padding(.horizontal, 15)
                
                HStack {
                    Image("search")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.black)
                    
                    Text("Where to?")
                        .font(.custom("UberMove-Medium", size: 20))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Button {
                        print("schedule was tapped")
                    } label: {
                        Image("schedule")
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding(.top)
        }
    }
}

// View for displaying recent locations
struct RecentLocation: View {
    var title: String // Title of the location
    var subtitle: String // Subtitle or address of the location
    
    var body: some View {
        HStack {
            Image("icon-time")
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.custom("UberMove-Medium", size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(subtitle)
                    .font(.custom("UberMove-Regular", size: 16))
                    .lineLimit(1)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

// Header for suggestions section
struct SuggestionHeader: View {
    var body: some View {
        HStack {
            Text("Suggestions")
                .font(.custom("UberMove-Medium", size: 22))
                .fontWeight(.semibold)
            
            Spacer()
            
            Text("See all")
                .font(.custom("UberMove-Medium", size: 16))
        }
        .padding(.horizontal, 15)
        .padding(.vertical)
    }
}

// List of suggestions
struct SuggestionList: View {
    var body: some View {
        HStack(spacing: 15) {
            // Small card for each suggestion
            SmallCard(imageName: "car", name: "Ride")
                .overlay {
                    ZStack {
                        Image("green-card")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                        
                        Text("Promo")
                            .font(.custom("UberMove-Medium", size: 11))
                            .foregroundStyle(.white)
                    }
                    .offset(y: -45)
                }
                .padding(.top)
            
            SmallCard(imageName: "package", name: "Package")
                .overlay {
                    ZStack {
                        Image("green-card")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                        
                        Text("Promo")
                            .font(.custom("UberMove-Medium", size: 11))
                            .foregroundStyle(.white)
                    }
                    .offset(y: -45)
                }
                .padding(.top)
            
            SmallCard(imageName: "reserve", name: "Reserve")
                .padding(.top)
            
            SmallCard(imageName: "car-rental", name: "Rentals")
                .padding(.top)
        }
        .padding(.horizontal)
    }
}

// View for saving with Uber
struct SaveWithUber: View {
    var body: some View {
        VStack {
            Text("Ways to save with Uber")
                .font(.custom("UberMove-Bold", size: 22))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15.0) {
                    Image("UberMotoRides")
                    Image("ShuttleRides")
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

// View for more ways to use Uber
struct UseUber: View {
    var body: some View {
        VStack {
            Text("More ways to use Uber")
                .font(.custom("UberMove-Bold", size: 22))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15.0) {
                    Image("TravelIntercity")
                    Image("HourlyRentals")
                        .padding(.bottom)
                }
                .padding(.horizontal, 15)
            }
        }
    }
}
