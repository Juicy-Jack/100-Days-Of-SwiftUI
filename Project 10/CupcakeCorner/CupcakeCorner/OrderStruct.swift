//
//  Order.swift
//  CupcakeCorner
//
//  Created by Furkan Doğan on 1.07.2023.
//

import SwiftUI

struct OrderStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.isEmpty {
            return false
        } else{
            return true
        }
    }
    
    var cost: Double{
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        if extraFrosting {
            cost += 1
        }
        if addSprinkles {
            cost += 0.5
        }
        return cost
    }
    /*
    enum CodingKeys: CodingKey{
        case type, name, streetAddress, extraFrosting, addSprinkles, city, zip, quantity
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        try container.encode(quantity, forKey: .quantity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        quantity = try container.decode(Int.self, forKey: .quantity)
    }
        
    init() {}*/
}
