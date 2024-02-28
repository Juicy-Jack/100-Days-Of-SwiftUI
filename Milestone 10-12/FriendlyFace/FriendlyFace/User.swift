//
//  User.swift
//  FriendlyFace
//
//  Created by Furkan Doğan on 5.07.2023.
//

import Foundation

struct User: Codable, Identifiable{
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int16
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
