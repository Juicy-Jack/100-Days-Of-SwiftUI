//
//  Arrow.swift
//  Drawing
//
//  Created by Furkan Doğan on 26.06.2023.
//

import SwiftUI

struct Arrow: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY/4))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY/4))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/4))
        path.addLine(to: CGPoint(x: 3 * rect.midX / 2, y: rect.maxY/4))
        path.addLine(to: CGPoint(x: 3 * rect.midX / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY / 4))
        return path
    }
}

struct ArrowView: View {
    @State private var thickness = 5.0
    
    var body: some View {
        VStack{
            Arrow()
                .stroke(Color.orange,
                        style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .miter))
                .padding()
            Text("Thickness")
            Slider(value: $thickness, in: 1...50)
                .padding(.horizontal)
        }
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
