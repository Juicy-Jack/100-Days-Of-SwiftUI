//
//  ContentView.swift
//  Funtiply
//
//  Created by Furkan Doğan on 21.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State var changeView = false
    @State private var questions = [Question] ()
    @State private var questionNum = 5
    @State private var questionNumArr = [5, 10, 15, 20]
    @State private var upTo = 2
    let difButtonNames1 = ["buffalo", "chicken", "cow"]
    let difButtonNames2 = ["frog", "goat", "gorilla"]
    let difButtonNames3 = ["crocodile", "duck", "elephant"]
    let difButtonNames4 = ["panda", "parrot", "penguin"]
    let questionNumButtonNames = ["pig", "rabbit", "snake", "whale"]
    let difButtonVars1 = [2, 6, 10]
    let difButtonVars2 = [3, 7, 11]
    let difButtonVars3 = [4, 8, 12]
    let difButtonVars4 = [5, 9, 13]
    
    var body: some View {
            NavigationView{
                Form{
                    Section(header: Text("Which multiplications do you want to practice?")
                        .font(.headline)){
                            VStack{
                                ForEach(0..<3) { row in
                                    HStack(spacing: 30){
                                        Spacer()
                                        Button{
                                            upTo = difButtonVars1[row]
                                        }
                                    label: {
                                        VStack{
                                            CircleImage(imageName: difButtonNames1[row])
                                            Text(String(difButtonVars1[row]))
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                        
                                        
                                        Button{
                                            upTo = difButtonVars2[row]
                                        }
                                    label: {
                                        VStack{
                                            CircleImage(imageName: difButtonNames2[row])
                                            Text(String(difButtonVars2[row]))
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                        
                                        Button{
                                            upTo = difButtonVars3[row]
                                        }
                                    label: {
                                        VStack{
                                            CircleImage(imageName: difButtonNames3[row])
                                            Text(String(difButtonVars3[row]))
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                        
                                        Button{
                                            upTo = difButtonVars4[row]
                                        }
                                    label: {
                                        VStack{
                                            CircleImage(imageName: difButtonNames4[row])
                                            Text(String(difButtonVars4[row]))
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                        Spacer()
                                    }
                                }
                                Text("Up to: \(upTo)")
                            }
                        }
                    
                    Section(header: Text("How many questions do you want to solve?")
                        .font(.headline)){
                            VStack{
                                HStack(spacing: 20){
                                    Spacer()
                                    ForEach(0..<4){ index in
                                        Button{
                                            questionNum = questionNumArr[index]
                                        }
                                    label: {
                                        VStack{
                                            RectangleImage(imageName: questionNumButtonNames[index])
                                            Text(String(questionNumArr[index]))
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    }
                                    Spacer()
                                }
                                Text("\(questionNum) Questions")
                            }
                        }
                    HStack{
                        Spacer()
                        NavigationLink {
                            QuestionView(questionNum: $questionNum, upTo: $upTo)
                        } label: {
                            Text("Start")
                        }
                        Spacer()
                    }
                }
            }
        }
    }






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
