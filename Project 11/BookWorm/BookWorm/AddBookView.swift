//
//  AddBookView.swift
//  BookWorm
//
//  Created by Furkan Doğan on 2.07.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    @State private var startDate = Date.now
    @State private var finishDate = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var isItValid: Bool{
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    VStack{
                        DatePicker("Start date", selection: $startDate, in: ...Date(), displayedComponents: .date)
                        DatePicker("Finish date", selection: $finishDate, in: ...Date(), displayedComponents: .date)
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section{
                    Button{
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.author = author
                        newBook.title = title
                        newBook.genre = genre
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        newBook.startDate = startDate
                        newBook.finishDate = finishDate
                        
                        try? moc.save()
                        dismiss()
                    } label: {
                            Text("Save")
                                .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(isItValid == false)
                }
            }
            .navigationTitle("Add a book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
