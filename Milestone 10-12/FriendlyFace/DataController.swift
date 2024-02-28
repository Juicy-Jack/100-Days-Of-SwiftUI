//
//  DataController.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 6.07.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {

    let container = NSPersistentContainer(name: "FriendlyFaceData")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

}
