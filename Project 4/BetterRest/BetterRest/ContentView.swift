//
//  ContentView.swift
//  BetterRest
//
//  Created by Furkan Doğan on 18.05.2023.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    func calculateBedtime() -> String {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hours = (components.hour ?? 0) * 60 * 60
                let minutes = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
                
                let sleepTime = wakeUp - prediction.actualSleep
                
                let bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
                return bedTime
            } catch {
                alertTitle = "Error"
                alertMessage = "Sorry, there was a problem calculating your bedtime."
                showingAlert = true
            }
            
            return ""
        }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Recommended bedtime")
                    .font(.headline)) {
                    HStack{
                        Spacer()
                        Text("\(calculateBedtime())")
                            .font(.title)
                        Spacer()
                    }
                }
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)){
                    HStack{
                        Spacer()
                        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Spacer()
                    }
                }
                
                Section(header: Text("Desired amount of sleep")
                    .font(.headline)){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section{
                    Picker("Daily cup of coffee intake", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            Text("\($0)")
                        }
                    }
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
