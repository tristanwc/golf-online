//
//  ModeSwitchView.swift
//  Golf-Online
//
//  Created by tristan.cortez on 12/10/22.
//

import SwiftUI

struct ModeSwitchView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        VStack {
            Picker("Mode", selection: $isDarkMode) {
                Text("Light")
                    .tag(false)
                Text("Dark")
                    .tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
        }
    }
}

struct ModeSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSwitchView()
    }
}
