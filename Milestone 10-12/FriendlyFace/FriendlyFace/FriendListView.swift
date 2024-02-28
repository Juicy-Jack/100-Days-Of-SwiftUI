//
//  FriendListView.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 6.07.2023.
//

import SwiftUI

struct FriendListView: View {
    let user: User
    var body: some View {
        List(user.friends){friend in
            Text(friend.name)
        }
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var users: [User] = Bundle.main.decode("friendface.json")
    static var previews: some View {
        FriendListView(user: users[0])
    }
}
