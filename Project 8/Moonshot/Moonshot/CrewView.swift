//
//  CrewView.swift
//  Moonshot
//
//  Created by Furkan Doğan on 25.06.2023.
//

import SwiftUI

struct CrewView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    } label:{
                        HStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width:104, height:72)
                                .clipShape(Capsule())
                                .overlay(Capsule()
                                    .strokeBorder(.white, lineWidth: 1))
                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

/*struct CrewView_Previews: PreviewProvider {

    static var previews: some View {
        CrewView()
    }
}
*/
