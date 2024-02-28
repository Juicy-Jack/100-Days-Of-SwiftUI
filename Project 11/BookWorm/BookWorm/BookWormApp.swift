//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Furkan Doğan on 2.07.2023.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
