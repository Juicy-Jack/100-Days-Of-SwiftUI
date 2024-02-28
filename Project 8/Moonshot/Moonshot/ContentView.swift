//
//  ContentView.swift
//  Moonshot
//
//  Created by Furkan Doğan on 23.06.2023.
//

import SwiftUI


struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var showingGrid = true
    var body: some View {Group {
        if showingGrid {
            GridView(astronauts: astronauts, missions: missions, showingGrid: $showingGrid)
        } else {
            ListView(astronauts: astronauts, missions: missions, showingGrid: $showingGrid)
        }
    }
    .navigationTitle("My Group")
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
