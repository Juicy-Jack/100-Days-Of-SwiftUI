//
//  EditCards.swift
//  FlashZilla
//
//  Created by Furkan Doğan on 28.09.2023.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var flashCards = FlashCards()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(flashCards.cards) { card in
                        VStack {
                            Text("\(card.prompt)")
                                .font(.headline)
                            
                            Text("\(card.answer)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear {
                flashCards.loadData()
            }
        }
    }
    
    func done() {
        dismiss()
    }
    
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        newPrompt = ""
        newAnswer = ""
        
        let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        flashCards.insertCard(newCard: newCard, at: 0)
        flashCards.saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        flashCards.removeCards(offsets: offsets)
    }
}

#Preview {
    EditCards()
}
