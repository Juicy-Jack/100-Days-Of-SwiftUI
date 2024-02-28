//
//  ContentView.swift
//  DiceRoller
//
//  Created by Furkan Doğan on 2.10.2023.
//

import SwiftUI
import CoreHaptics



struct ContentView: View {
    @StateObject var dices = Results()
    @State private var d1 = Dice()
    var d2 = Dice()
    @State private var side = 6.0
    @State private var dice1 = 0
    @State private var dice2 = 0
    @State private var result = 0
    @State var supportsHaptics: Bool = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section("Roll") {
                        Slider(
                                value: $side,
                                in: 4...100,
                                step: 1
                            ) {
                                Text("Side")
                            } minimumValueLabel: {
                                Text("4")
                            } maximumValueLabel: {
                                Text("100")
                            }
                    Text("Type: \(Int(side))-sided")
                    
                    Button{
                        simpleSuccess()
                        d1.roll(side: Int(side))
                        d2.roll(side: Int(side))
                        d1.result = d1.value + d2.value
                        d2.result = d1.value + d2.value
                        dices.addNewElement(newElements: d1)
                        d1 = Dice()
                    } label: {
                        Label("Roll", systemImage: "dice")
                    }
                }
                Text("Result: \(result)")
                
                List {
                    ForEach(dices.rolls) { roll in
                        Text("Total: \(roll.result)")
                    }
                    .onDelete(perform: { indexSet in
                        dices.removeRow(atOffsets: indexSet)
                    })
                }
            }
        }
        .onChange(of: Int(side), perform: { value in
            d1.assignSide(side: value)
            d2.assignSide(side: value)
        })
        }
    }


#Preview {
    ContentView()
}
