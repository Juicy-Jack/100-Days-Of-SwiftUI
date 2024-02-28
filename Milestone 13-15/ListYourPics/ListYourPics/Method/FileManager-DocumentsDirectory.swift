//
//  FileManager-DocumentsDirectory.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 16.07.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
