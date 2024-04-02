//
//  TabView.swift
//  Uber
//
//  Created by Ashwin Kumar on 14/02/24.
//

import SwiftUI

// MainTabBar: A SwiftUI view representing the main tab bar for the Uber app.
struct MainTabBar: View {
    var body: some View {
        // Vertical stack to hold the TabView and avoid spacing between its children.
        VStack(spacing: 0.0) {
            // TabView to display different views for each tab item.
            TabView{
                // HomeView tab item.
                HomeView()
                    .tabItem {
                        Image(systemName: "house") // Icon for Home tab item.
                        Text("Home") // Text label for Home tab item.
                    }
                
                // ServicesView tab item.
                ServicesView()
                    .tabItem {
                        Image(systemName: "square.grid.3x3.fill") // Icon for Services tab item.
                        Text("Services") // Text label for Services tab item.
                    }
                
                // ActivityView tab item.
                ActivityView()
                    .tabItem {
                        Image(systemName: "doc.plaintext") // Icon for Activity tab item.
                        Text("Activity") // Text label for Activity tab item.
                    }
                
                // AccountView tab item.
                AccountView()
                    .tabItem {
                        Image(systemName: "person") // Icon for Account tab item.
                        Text("Account") // Text label for Account tab item.
                    }
            }
            // Set accent color for the tab bar.
            .accentColor(.black)
        }
    }
}

#Preview {
    MainTabBar() // Preview for MainTabBar.
}
