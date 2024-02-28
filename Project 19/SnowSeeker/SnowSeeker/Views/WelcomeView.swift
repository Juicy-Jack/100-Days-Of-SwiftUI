//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Furkan Doğan on 3.10.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; press Resorts button to show it.")
                .foregroundStyle(.secondary)
        }
        
    }
}

#Preview {
    WelcomeView()
}
