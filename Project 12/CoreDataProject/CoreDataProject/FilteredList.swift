//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Furkan Doğan on 4.07.2023.
//

import SwiftUI
import CoreData

enum formats {
    case firstName, lastName
}


struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: formats, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        switch filterKey{
        case .firstName:
            _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", "firstName", filterValue))

        case .lastName:
            _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", "lastName", filterValue))
        }
        self.content = content
    }
}
