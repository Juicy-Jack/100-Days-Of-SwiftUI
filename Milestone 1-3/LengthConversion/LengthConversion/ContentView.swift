//
//  ContentView.swift
//  LengthConversion
//
//  Created by Furkan Doğan on 11.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputLength = 0.0
    @State private var inputUnit = "meters"
    @State private var outputUnit = "meters"
    let units = ["meters", "kilometers", "feets", "yards", "miles"]
    @FocusState private var inputIsFocused: Bool
    
    var convertedLength: Double {
        var tempLength = 0.0
        if(inputUnit == "meters") {
            if(outputUnit == "meters") {
                tempLength = inputLength
            }
            else if(outputUnit == "kilometers") {
                tempLength = inputLength * 0.001
            }
            else if(outputUnit == "feets") {
                tempLength = inputLength * 3.28084
            }
            else if(outputUnit == "yards") {
                tempLength = inputLength * 1.09361
            }
            else if(outputUnit == "miles") {
                tempLength = inputLength * 0.000621371
            }
        }
        else if(inputUnit == "kilometers") {
            if(outputUnit == "meters") {
                tempLength = inputLength * 1000
            }
            else if(outputUnit == "kilometers") {
                tempLength = inputLength
            }
            else if(outputUnit == "feets") {
                tempLength = inputLength * 3280.84
            }
            else if(outputUnit == "yards") {
                tempLength = inputLength * 1093.61
            }
            else if(outputUnit == "miles") {
                tempLength = inputLength * 0.621371
            }
        }
        else if(inputUnit == "feets") {
            if(outputUnit == "meters") {
                tempLength = inputLength * 0.3048
            }
            else if(outputUnit == "kilometers") {
                tempLength = inputLength * 0.0003048
            }
            else if(outputUnit == "feets") {
                tempLength = inputLength
            }
            else if(outputUnit == "yards") {
                tempLength = inputLength * 0.333333
            }
            else if(outputUnit == "miles") {
                tempLength = inputLength * 0.000189394
            }
        }
        else if(inputUnit == "yards") {
            if(outputUnit == "meters") {
                tempLength = inputLength * 0.9144
            }
            else if(outputUnit == "kilometers") {
                tempLength = inputLength * 0.0009144
            }
            else if(outputUnit == "feets") {
                tempLength = inputLength * 3
            }
            else if(outputUnit == "yards") {
                tempLength = inputLength
            }
            else if(outputUnit == "miles") {
                tempLength = inputLength * 0.000568182
            }
        }
        else if(inputUnit == "miles") {
            if(outputUnit == "meters") {
                tempLength = inputLength * 1609.34
            }
            else if(outputUnit == "kilometers") {
                tempLength = inputLength * 1.60934
            }
            else if(outputUnit == "feets") {
                tempLength = inputLength * 5280
            }
            else if(outputUnit == "yards") {
                tempLength = inputLength * 1760
            }
            else if(outputUnit == "miles") {
                tempLength = inputLength
            }
        }
        return tempLength
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Length", value: $inputLength, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section {
                    Text(convertedLength, format: .number)
                    
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Length Convertor")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
