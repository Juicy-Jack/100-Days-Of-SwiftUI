//
//  Dice.swift
//  DiceRoller
//
//  Created by Furkan Doğan on 2.10.2023.
//

import Foundation

class Dice: Identifiable, Codable {
    var id = UUID()
    var numOfSide = 0
    var value = 0
    var result = 0
    
    func roll(side: Int){
        
        value = Int.random(in: 1...side)
    }
    
    func assignSide(side: Int) {
        numOfSide = side
    }
    
}


@MainActor class Results: ObservableObject {
    @Published private(set) var rolls: [Dice]
    let saveKey = "Rolls"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedRolls")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            rolls = try JSONDecoder().decode([Dice].self, from: data)
        } catch {
            rolls = []
        }
    }
    
    func addNewElement(newElements: Dice) {
        rolls.append(newElements)
        save()
    }
    
    func removeRow(atOffsets: IndexSet) {
        rolls.remove(atOffsets: atOffsets)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(rolls)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
