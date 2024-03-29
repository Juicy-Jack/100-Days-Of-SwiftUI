//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Furkan Doğan on 1.07.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.order.name)
                TextField("Street address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                }label: {
                    Text("Checkout")
                }
            }
            .disabled(order.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct AddressView_Previews: PreviewProvider {
        static var previews: some View {
            AddressView(order: OrderClass())
        }
    }
}
