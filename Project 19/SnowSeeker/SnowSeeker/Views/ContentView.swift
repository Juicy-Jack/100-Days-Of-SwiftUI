//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Furkan Doğan on 3.10.2023.
//

import SwiftUI

extension View {
    
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    @State private var isShowingSortingOptions = false
    @State private var sort: sortType = .defaultOrder
    
    enum sortType {
        case alphabeticalOrder, defaultOrder, countryOrder
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List(filteredSortedResorts) { resort in
                    NavigationLink{
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort.")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isShowingSortingOptions.toggle()
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
                .confirmationDialog("Sorting", isPresented: $isShowingSortingOptions) {
                    Button {
                        self.sort = .defaultOrder
                        print(self.sort)
                    } label: {
                        Label("Default", systemImage: "checkmark")
                    }
                    Button {
                        self.sort = .alphabeticalOrder
                    } label: {
                        Label("Resort Name", systemImage: "checkmark")
                    }
                    Button("Resort Country") {self.sort = .countryOrder}
                        }
            }
            .environmentObject(favorites)
        } else {
            NavigationView {
                List(filteredSortedResorts) { resort in
                    NavigationLink{
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort.")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
                .confirmationDialog("Sorting", isPresented: $isShowingSortingOptions) {
                    Button {
                        self.sort = .defaultOrder
                        print(self.sort)
                    } label: {
                        Label("Default", systemImage: "checkmark")
                    }
                    Button {
                        self.sort = .alphabeticalOrder
                    } label: {
                        Label("Resort Name", systemImage: "checkmark")
                    }
                    Button("Resort Country") {self.sort = .countryOrder}
                        }
                
                WelcomeView()
            }
            .phoneOnlyNavigationView()
            .environmentObject(favorites)
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var filteredSortedResorts: [Resort] {
        switch sort {
        case .alphabeticalOrder:
            return filteredResorts.sorted { $0.id < $1.id }
        case .defaultOrder:
            return filteredResorts
        case .countryOrder:
            return filteredResorts.sorted { $0.country < $1.country}
        }
    }
}

#Preview {
    ContentView()
}
