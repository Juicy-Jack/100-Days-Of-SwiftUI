//
//  FriendlyFaceApp.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 5.07.2023.
//

import SwiftUI

@main
struct FriendlyFaceApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
