//
//  ContentView.swift
//  DrawingChallengeDay46
//


import SwiftUI

struct ColorCyclingRect: View {
    var amount = 0.0
    var steps = 100
    
    
    // These variables will function as our UnitPoint. We previously said .top/.bottom. Using these variables make the start and end points customizable.
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                    ),
                    lineWidth: 2
                )
            }
        }
        .drawingGroup() // This modifier tells SwiftUI to render the content of the view into an off screen image, before putting it back on the screen as a single piece of rendered output. Behind the scenes, this is not powered by Core Animation. Instead, it's powered by Apple's graphics API Metal.
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount // If we are circle 25 of 100, for example, that is our targetHue
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle: View {
    @State private var colorCycle = 0.0
    @State var gradientStartX = 0.5
    @State var gradientStartY = 0.0
    @State var gradientEndX = 0.5
    @State var gradientEndY = 1.0
    
    var body: some View {
        VStack {
            ColorCyclingRect(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 300)
            
            HStack {
                Text("Color")
                Slider(value: $colorCycle)
            }
            
            HStack {
                Text("Start X")
                Slider(value: $gradientStartX)
            }
            
            HStack {
                Text("Start Y")
                Slider(value: $gradientStartY)
            }
            
            HStack {
                Text("End X")
                Slider(value: $gradientEndX)
            }
            
            HStack {
                Text("End Y")
                Slider(value: $gradientEndY)
            }
        }
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
