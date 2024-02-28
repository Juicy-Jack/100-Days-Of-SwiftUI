//
//  CircleImage.swift
//  Funtiply
//
//  Created by Furkan Doğan on 5.10.2023.
//

import SwiftUI

struct CircleImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .shadow(color: .black, radius: 2)
    }
}
/*
#Preview {
    CircleImage()
}
*/
