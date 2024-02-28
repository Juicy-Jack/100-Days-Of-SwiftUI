//
//  SkiDetaildView.swift
//  SnowSeeker
//
//  Created by Furkan Doğan on 3.10.2023.
//

import SwiftUI

struct SkiDetailsView: View {
    var resort: Resort
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)")
                    .font(.title3)
            }
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SkiDetailsView(resort: Resort.example)
}
