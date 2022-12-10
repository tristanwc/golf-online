//
//  TourView.swift
//  Golf-Online
//
//  Created by tristan.cortez on 12/8/22.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        TabView {
            WorldRankingView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("World Rankings")
                }
            ProjectedRankingView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Projected Rankings")
                }
        }
        
        
    }
}

struct TourView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
