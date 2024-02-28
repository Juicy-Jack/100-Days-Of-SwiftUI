//
//  ProfilePicView.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 5.07.2023.
//

import SwiftUI

struct ProfilePicView: View {
    var picName: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            Image(picName)
                .resizable()
                .scaledToFit()
                .toolbar(){
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            dismiss()
                        }label: {
                            Text("Done")
                        }
                    }
            }
        }
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var picName = "blankPic"
    static var previews: some View {
        ProfilePicView(picName: picName)
    }
}
