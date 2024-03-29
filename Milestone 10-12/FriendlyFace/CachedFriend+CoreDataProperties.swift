//
//  CachedFriend+CoreDataProperties.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 6.07.2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?

    var wrappedID: UUID{
        id ?? UUID()
    }
    var wrappedName: String{
        name ?? "Unknown"
    }
}

extension CachedFriend : Identifiable {

}
