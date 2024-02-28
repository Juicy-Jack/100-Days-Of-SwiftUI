//
//  RectangleImage.swift
//  Funtiply
//
//  Created by Furkan Doğan on 5.10.2023.
//

import SwiftUI

struct RectangleImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .frame(width: 70, height: 70)
            .clipShape(Rectangle())
            
    }
}
/*
#Preview {
    RectangleImage()
}
*/
