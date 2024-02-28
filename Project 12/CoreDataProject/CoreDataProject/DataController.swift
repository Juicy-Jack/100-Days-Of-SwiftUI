//
//  DataController.swift
//  CoreDataProject
//
//  Created by Furkan Doğan on 4.07.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {

    let container = NSPersistentContainer(name: "CoreDataProject")

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

