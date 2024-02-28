//
//  ContentView.swift
//  iExpense
//
//  Created by Furkan Doğan on 22.06.2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


class Expenses: ObservableObject{
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView{
            VStack{
                    List{
                        Section(header: Text("Personal").font(.headline)){
                        ForEach(expenses.items){ item in
                            if(item.type == "Personal"){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.name)
                                            .font(.headline)
                                    }
                                    
                                    Spacer()
                                    if(item.amount < 10){
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.black)
                                    }
                                    else if(item.amount < 100){
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.orange)
                                    }
                                    else{
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.red)
                                    }
                                }
                                .accessibilityElement(children: .combine)
                            }
                        }.onDelete(perform: removeItems)
                    }
                }
                    List{
                        Section(header: Text("Business").font(.headline)){
                        ForEach(expenses.items){ item in
                            if(item.type == "Business"){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.name)
                                            .font(.headline)
                                    }
                                    
                                    Spacer()
                                    if(item.amount < 10){
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.black)
                                    }
                                    else if(item.amount < 100){
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.orange)
                                    }
                                    else{
                                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                            .foregroundColor(.red)
                                    }
                                }
                                .accessibilityElement(children: .combine)

                            }
                        }.onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
