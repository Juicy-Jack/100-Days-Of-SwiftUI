//
//  Card.swift
//  FlashZilla
//
//  Created by Furkan Doğan on 28.09.2023.
//

import Foundation


struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "What is the name of Steve Vai's signature guitar?", answer: "JEM")
    
}

@MainActor class FlashCards: ObservableObject {
    @Published private(set) var cards: [Card]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func getIndex(card: Card) -> Int {
        return cards.firstIndex(of: card) ?? 0
    }
    
    func getCount() -> Int {
        return cards.count
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
 
    func removeCards(offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func insertCard(newCard: Card, at: Int) {
        cards.insert(newCard, at: at)
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
}
