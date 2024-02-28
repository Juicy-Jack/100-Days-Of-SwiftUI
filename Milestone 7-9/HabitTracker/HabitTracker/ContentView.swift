//
//  ContentView.swift
//  HabitTracker
//
//  Created by Furkan Doğan on 26.06.2023.
//

import SwiftUI
import Foundation

struct Activity: Equatable, Codable, Identifiable{
    var id = UUID()
    var name: String
    var completedDays: [String] = []
    
    mutating func convertTodayToArray(date: Date){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateStr = formatter.string(from: date)
        let tempIn = completedDays.lastIndex(of: dateStr)
        
        if tempIn == nil {
            completedDays.append(formatter.string(from: date))
        }else{
            completedDays.remove(at: tempIn ?? 0)
        }
    }
}

class Activities: ObservableObject{
    @Published var items = [Activity] () {
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView: View {
    @StateObject var habits = Activities()
    @State private var showingAddView = false
    
    func convertDateToString() -> String{
        let today = Date.now
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let todayStr = formatter.string(from: today)
        
        return todayStr
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
                VStack(alignment: .leading){
                    /*HStack{
                        Text(now, format: .dateTime.month(.wide))
                            .frame(width: geo.size.width * 0.25, alignment: .leading)
                            .font(.system(size: 18))
                            .padding(.leading)
                        Spacer()
                        VStack{
                            Text(now.addingTimeInterval(-6 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-6 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)

                        VStack{
                            Text(now.addingTimeInterval(-5 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-5 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)

                        VStack{
                            Text(now.addingTimeInterval(-4 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-4 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)

                        VStack{
                            Text(now.addingTimeInterval(-3 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-3 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)
                        VStack{
                            Text(now.addingTimeInterval(-2 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-2 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)

                        VStack{
                            Text(now.addingTimeInterval(-1 * 86400), format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now.addingTimeInterval(-1 * 86400), format: .dateTime.weekday(.short))
                                .font(.system(size: 12))

                        }
                        .padding(.trailing)

                        VStack{
                            Text(now, format: .dateTime.day())
                                .font(.system(size: 12))
                            Text(now, format: .dateTime.weekday(.short))
                                .font(.system(size: 12))
                        }
                        .padding(.trailing)
                    }*/
                    
                    List {
                        ForEach(habits.items) {item in
                            NavigationLink{
                                DetailView(activity: item, habits: habits)
                            }label: {
                                HStack{
                                    Text(item.name)
                                        .font(.headline)
                                        .frame(maxWidth: geo.size.width * 0.28, alignment: .leading)
                                        .padding(.trailing)
                                    Button{
                                        let tempIn = habits.items.firstIndex(of: item)
                                        habits.items[tempIn ?? 0].convertTodayToArray(date: Date.now)
                                    }label:{
                                        if(item.completedDays.contains(convertDateToString())){
                                            Image(systemName: "minus.circle")
                                        }else{
                                            Image(systemName: "plus.circle")
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    .foregroundColor(.primary)
                                    
                                    Text("\(item.completedDays.count)")
                                    
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                        }
                    }
                    .navigationTitle("HabitTrack")
                    .toolbar{
                        Button{
                            showingAddView.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddView){
                AddView(habits: habits)
            }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
