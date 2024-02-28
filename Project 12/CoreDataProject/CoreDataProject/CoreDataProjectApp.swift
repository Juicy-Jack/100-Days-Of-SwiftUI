//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Furkan Doğan on 4.07.2023.
//


import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    @Environment(\.scenePhase) var scenePhase

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
