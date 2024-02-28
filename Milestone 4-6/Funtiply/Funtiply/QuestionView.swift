//
//  QuestionView.swift
//  Funtiply
//
//  Created by Furkan Doğan on 5.10.2023.
//

import SwiftUI

struct QuestionView: View {
    @Binding var questionNum: Int
    @Binding var upTo: Int
    @State private var questions = [Question] ()
    @State private var currQuestion = 0
    @State private var userAnswer = 0
    @State private var showNewGameAlert = false
    @State private var showRestartAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var userScore = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    struct Question {
        var qText: String
        var answer: Int
    }
    
    var body: some View {
        NavigationView{
            Form{
                VStack{
                    Section(header: Text("Question")){
                        Text(questions.isEmpty ? "" : "\(questions[currQuestion].qText)")
                    }
                    Section{
                        TextField("Answer", value: $userAnswer, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Score: \(userScore)")
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isCorrect(userAnswer: userAnswer, question: questions[currQuestion])
                        userAnswer = 0
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Restart the game"){
                        showRestartAlert.toggle()
                    }
                    .foregroundColor(.pink)
                }
            }
            .navigationTitle("Funtiply")
            .onAppear {
                createQuestion(upTo: upTo, questionNum: questionNum)
            }
            .alert(alertTitle, isPresented: $showNewGameAlert){
                if currQuestion == questionNum - 1{
                    Button("New Game"){
                        restartGame()
                    }
                } else{
                    Button("OK") {
                        currQuestion += 1
                    }
                }
            } message: {
                Text(alertMessage)
            }
            .alert("Restar the game!", isPresented: $showRestartAlert){
                Button("Cancel", role: .cancel){}
                Button("Restart", role: .destructive){
                    restartGame()
                }
            } message: {
                Text("Your score will be deleted.")
            }
        }
    }
    
    func createQuestion(upTo: Int, questionNum: Int){
        questions = []
        for _ in 1...questionNum{
            let num1 = Int.random(in: 1..<upTo + 1)
            let num2 = Int.random(in: 1..<upTo + 1)
            let tempQ = Question(qText: "\(num1) X \(num2) = ?", answer: num1 * num2)
            questions.append(tempQ)
        }
    }
    
    func isCorrect(userAnswer: Int, question: Question){
        if currQuestion == questionNum - 1{
            if userAnswer == question.answer{
                userScore += 1
                alertTitle = "Correct!"
                alertMessage = "Your answer is right.\nTotal score: \(userScore)."
                showNewGameAlert = true
            } else{
                alertTitle = "Wrong!"
                alertMessage = "Your answer is wrong.\nTotal score: \(userScore)."
                showNewGameAlert = true
            }
        }else{
            if userAnswer == question.answer{
                userScore += 1
                alertTitle = "Correct!"
                alertMessage = "Your answer is right."
                showNewGameAlert = true
            } else{
                alertTitle = "Wrong!"
                alertMessage = "Your answer is wrong."
                showNewGameAlert = true
            }
        }
    }
    func restartGame(){
        userScore = 0
        currQuestion = 0
        questions = []
        self.presentationMode.wrappedValue.dismiss()
    }
    func startNewgame(){
        userScore = 0
        currQuestion = 0
        questions = []
        self.presentationMode.wrappedValue.dismiss()
    }
}

/*
 #Preview {
 QuestionView(questionNum: $4, upTo: $3)
 }
 */
