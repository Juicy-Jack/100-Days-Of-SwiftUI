//
//  DetailView.swift
//  HabitTracker
//
//  Created by Furkan Doğan on 29.06.2023.
//

import SwiftUI

struct DetailView: View {
    var activity: Activity
    @ObservedObject var habits: Activities
    @State private var newDate = Date.now
    @State private var showingAlert = false
    
    func convertDateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let todayStr = formatter.string(from: date)
        
        return todayStr
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                if(activity.completedDays.count == 0){
                    Text("You haven't started yet.")
                        .padding()
                        .font(.largeTitle)
                } else {
                    if(activity.completedDays.count == 1){
                        Text("You completed \(activity.completedDays.count) time.")
                            .padding()
                            .font(.largeTitle)
                    } else {
                        Text("You completed \(activity.completedDays.count) times.")
                            .padding()
                            .font(.largeTitle)
                    }
                    if(activity.completedDays.contains(convertDateToString(date: Date.now))){
                        Text("You completed for today")
                    } else{
                        Text("You haven't done this today.")
                    }
                }
                Spacer()
                Text("Add completion")
                    .font(.largeTitle)
                HStack{
                    DatePicker("Add completion day.", selection: $newDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .padding()
                    Button{
                        if(activity.completedDays.contains(convertDateToString(date: newDate))){
                            showingAlert.toggle()
                        } else{
                            let tempIn = habits.items.firstIndex(of: activity)
                            habits.items[tempIn ?? 0].convertTodayToArray(date: newDate)
                        }
                    }label: {
                        Image(systemName: "plus.circle")
                    }
                    .foregroundColor(.primary)
                    .padding()
                }
                Spacer()
            }
                .navigationTitle(activity.name)
                .navigationBarTitleDisplayMode(.inline)
                .alert("This date is already added.", isPresented: $showingAlert){
                    Button("OK", role: .cancel) {}
                }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let habits = Activities()
    static let activity = habits.items[0]
    
    static var previews: some View {
        DetailView(activity: activity, habits: habits)
    }
}

