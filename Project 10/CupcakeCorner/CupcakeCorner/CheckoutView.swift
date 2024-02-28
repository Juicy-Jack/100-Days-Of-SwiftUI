//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Furkan Doğan on 1.07.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderClass
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderClass.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.order.quantity)x \(OrderStruct.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        }catch{
            print("Checkout failed.")
            showingError = true
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()

                }
                .frame(height: 233)
                .accessibilityHidden(true)

                
                Text("Your total is \(order.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingConfirmation){
                Button("OK"){}
            } message: {
                Text(confirmationMessage)
            }
            .alert("No internet connection", isPresented: $showingError){
                Button("OK") {}
            } message: {
                Text("Make sure you have internet connection.")
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderClass())
    }
}
