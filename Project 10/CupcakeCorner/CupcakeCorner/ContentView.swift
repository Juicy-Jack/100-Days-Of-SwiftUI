//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Furkan Doğan on 30.06.2023.
//

import SwiftUI


struct ContentView: View {

    @StateObject var order = OrderClass()
    var body: some View {
        
        
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake", selection: $order.order.type){
                        ForEach(OrderStruct.types.indices){
                            Text(OrderStruct.types[$0])
                        }
                    }
                  
                    Stepper("Number of cakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Any special request", isOn: $order.order.specialRequestEnabled.animation())
                    if order.order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label:{
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
