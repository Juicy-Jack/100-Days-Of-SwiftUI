//
//  DetailedView.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 5.07.2023.
//

import SwiftUI

struct DetailedView: View {
    let user: CachedUser
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    
                    Image("blankPic")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 150)
                    Text(user.wrappedName)
                        .font(.largeTitle)
                    Text(user.isActive ? "Online" : "Offline")
                        .font(.subheadline)
                    Text("\(user.age) years old")
                    Text("E-mail: \(user.wrappedEmail)")
                    Text("Register Date: \(user.wrappedRegistered.formatted(date: .numeric, time: .omitted))")
                    
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.bottom)
                }
                
                VStack{
                    Text("Bio")
                        .font(.headline)
                    Text(user.wrappedAbout)
                            .font(.subheadline)
                            .padding(.horizontal)
                    
                }
                .padding(.vertical)
                    
                VStack{
                    Text("Friends")
                        .font(.headline)
                        .padding(.bottom)
                    ForEach(user.friendsArray){friend in
                        Text(friend.wrappedName)
                    }
                }
                
            }
        }
    }
}
/*
struct DetailedView_Previews: PreviewProvider {
    static var users: [User] = Bundle.main.decode("friendface.json")
    static var previews: some View {
        DetailedView(user: users[0])
    }
}*/
