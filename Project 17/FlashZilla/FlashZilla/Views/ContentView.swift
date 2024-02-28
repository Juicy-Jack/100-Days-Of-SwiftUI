//
//  ContentView.swift
//  FlashZilla
//
//  Created by Furkan Doğan on 27.09.2023.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @StateObject var flashCards = FlashCards()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var isShowingEditScreen = false
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(flashCards.cards) { card in
                        let index = flashCards.getIndex(card: card)
                        CardView(card: card) { isCorrect in
                            if isCorrect {
                                withAnimation {
                                    removeCard(at: index)
                                }
                            } else {
                                restackCard(index: index)
                                
                            }
                            return
                        }
                        .stacked(at: index, in: flashCards.getCount())
                        .allowsHitTesting(index == flashCards.getCount() - 1)
                        .accessibilityHidden(index < flashCards.getCount() - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if flashCards.cards.isEmpty || timeRemaining == 0{
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        isShowingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            restackCard(index: flashCards.getCount() - 1)
                            
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: flashCards.getCount() - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
                .allowsHitTesting(timeRemaining > 0)
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if flashCards.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $isShowingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        flashCards.removeCard(at: index)
        if flashCards.cards.isEmpty {
            isActive = false
        }
    }
    
    func restackCard(index: Int) {
        guard index >= 0 else { return }
        let wrongCard = flashCards.cards[index]
        flashCards.removeCard(at: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
            flashCards.insertCard(newCard: wrongCard, at: 0)
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        flashCards.loadData()
    }
}
#Preview {
    ContentView()
}
