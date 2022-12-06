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
                .badge(4)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            CardListView()
                .tabItem {
                    Image(systemName: "menucard.fill")
                    Text("Cloud Cards")
                }
            MessageView()
                .badge(10)
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messages")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
