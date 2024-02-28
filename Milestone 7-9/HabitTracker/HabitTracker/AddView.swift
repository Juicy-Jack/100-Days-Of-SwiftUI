//
//  AddView.swift
//  HabitTracker
//
//  Created by Furkan Doğan on 27.06.2023.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    let activities = ["Read", "Meditate", "Workout", "Drink water", "Brush teeth", "Study", "Make bed", "Write journal", "Do skin care", "Read", "Walk", "Yoga", "Run", "Pray", "Clean", "Wake up at 6", "Do morning routine", "Take vitamins", "Eat healthy", "Eat no sweets", "Take cold shower", "Fast", "Write"]
    @ObservedObject var habits: Activities
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal){
                
                ScrollViewReader{ proxy in
                    LazyHStack{
                        TextField("Activity", text: $name)
                        
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.green, lineWidth: 2))
                        ForEach(activities, id: \.self){activity in
                            Button{
                                name = activity
                                if(activity == "Take cold shower" || activity == "Fast" || activity == "Write"){
                                    withAnimation{
                                        proxy.scrollTo(activity)
                                        
                                    }
                                } else{
                                    withAnimation{
                                        proxy.scrollTo(activity, anchor: .leading)
                                    }
                                }
                            } label: {
                                Text(activity)
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .foregroundColor(.primary)
                        }
                    }
                }
            }
            .frame(alignment: .top)
            .navigationTitle("Create")
            .toolbar{
                Button{
                    let activity = Activity(name: name)
                    if(name != ""){
                        habits.items.append(activity)
                        dismiss()
                    }
                    
                } label: {
                    Text("Done")
                }
            }
        }
        }
    }


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Activities())
    }
}
