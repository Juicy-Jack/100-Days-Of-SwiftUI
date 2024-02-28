//
//  Images.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 16.07.2023.
//

import Foundation
import SwiftUI 

let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")

class Images: Codable, ObservableObject{
    @Published var images: [UserImage]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            images = try JSONDecoder().decode([UserImage].self, from: data)
        } catch {
            images = []
        }
    }
    enum CodingKeys: CodingKey {
        case images, id    }
    
    
    // Initializer 2: For decoding the encoded data
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        images = try container.decode([UserImage].self, forKey: .images)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(images, forKey: .images)

        }
    
    func addImage(name: String, image: UIImage, latitude: Double, longitude: Double) {
        let newImage = UserImage(id: UUID(), name: name, image: image, longitude: longitude, latitude: latitude)
        images.append(newImage)
        print(images.count)
        objectWillChange.send()
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(images)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func remove(_ offsets: IndexSet) {
        images.remove(atOffsets: offsets)
        save()
    }
    
    
    }

