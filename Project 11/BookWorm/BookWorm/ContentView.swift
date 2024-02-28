//
//  ContentView.swift
//  BookWorm
//
//  Created by Furkan Doğan on 2.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            //find this book in our fetch request
            let book = books[offset]
            //delete this book
            moc.delete(book)
        }
        //save
        try? moc.save()
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books){book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                if book.rating == 1{
                                    Text(book.title ?? "unknown title")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                }else{
                                    Text(book.title ?? "unknown title")
                                        .font(.headline)
                                }
                                Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                                
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("BookWorm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add book", systemImage: "plus")
                        }
                    }
                        
                        ToolbarItem(placement: .navigationBarLeading){
                            EditButton()
                        }
                }
        }
        .sheet(isPresented: $showingAddScreen){
            AddBookView()
        }
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
