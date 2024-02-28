//
//  OrderClass.swift
//  CupcakeCorner
//
//  Created by Furkan Doğan on 2.07.2023.
//

import SwiftUI

class OrderClass: ObservableObject, Codable{
    @Published var order = OrderStruct()
    
    enum CodingKeys: CodingKey{
        case order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(OrderStruct.self, forKey: .order)
    }
    
    init() {}
}
