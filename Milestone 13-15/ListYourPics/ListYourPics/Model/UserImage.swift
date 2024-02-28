//
//  ImageData.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 16.07.2023.
//

import Foundation
import SwiftUI
import MapKit




struct UserImage: Identifiable, Comparable, Codable {
    var id: UUID
    let image: UIImage
    var name: String
    var longitude: Double
    var latitude: Double
    
    
    static func <(lhs: UserImage, rhs: UserImage) -> Bool {
        lhs.name < rhs.name
    }
    
    enum CodingKeys: CodingKey {
        case id, name, image, latitude, longitude
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
    
    // Initializer 1: For creating a UserImage instance elsewhere in the app
    init(id: UUID, name: String, image: UIImage, longitude: Double, latitude: Double) {
        self.id = id
        self.name = name
        self.image = image
        self.longitude = longitude
        self.latitude = latitude
    }
    
    // Initializer 2: For decoding the encoded data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        
        let imageData = try container.decode(Data.self, forKey: .image)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.image = decodedImage
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection]) // Do I need this line? Everything works without it
            try container.encode(jpegData, forKey: .image)
        }
    }

    
    static let example = UserImage(id: UUID(), name: "ex", image: UIImage(imageLiteralResourceName: "example"), longitude: -122.0089189, latitude: 37.3347302)
    }
