//
//  GridView.swift
//  Moonshot
//
//  Created by Furkan Doğan on 25.06.2023.
//

import SwiftUI

struct ListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    @Binding var showingGrid: Bool
    
    var body: some View {
            
            NavigationView{
                ScrollView{
                    VStack{
                        ForEach(missions) { mission in
                            NavigationLink{
                                MissionView(mission: mission, astronouts: astronauts)
                            } label: {
                                HStack{
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        .accessibilityHidden(true)

                                    
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                }
                                .background(.lightBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground))
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    Button{
                        showingGrid.toggle()
                    } label:{
                        Image(systemName: "square.grid.2x2")
            }
            
                }
            }
        }
    }


struct ListView_Previews: PreviewProvider {
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    @State static var showingGrid = true

    static var previews: some View {
        ListView(astronauts: astronauts, missions: missions, showingGrid: $showingGrid)
    }
}
