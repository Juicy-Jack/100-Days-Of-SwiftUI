//
//  GridView.swift
//  Moonshot
//
//  Created by Furkan Doğan on 25.06.2023.
//

import SwiftUI

struct GridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    @Binding var showingGrid: Bool
    
    var body: some View {
            let columns = [GridItem(.adaptive(minimum: 150))]
            
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(missions) { mission in
                            NavigationLink{
                                MissionView(mission: mission, astronouts: astronauts)
                            } label: {
                                VStack{
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
                                    .background(.lightBackground)
                                }
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
                        Image(systemName: "list.bullet")
            }
            
                }
            }
        }
    }


struct GridView_Previews: PreviewProvider {
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    @State static var showingGrid = true
    static var previews: some View {
        GridView(astronauts: astronauts, missions: missions, showingGrid: $showingGrid)
    }
}
