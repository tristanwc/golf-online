//
//  ContentView.swift
//  Golf-Online
//
//  Created by tristan.cortez on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            WorldRankingView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("World Ranking")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            CardListView()
                .tabItem {
                    Image(systemName: "menucard.fill")
                    Text("Cards")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
