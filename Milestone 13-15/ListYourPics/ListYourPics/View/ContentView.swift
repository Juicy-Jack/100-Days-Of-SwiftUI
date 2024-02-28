//
//  ContentView.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 15.07.2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var images = Images()
    @State private var inputImage: UIImage?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var curLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    let locationFetcher = LocationFetcher()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
    
    
    
    
    
    func save() {
        do {
            let data = try JSONEncoder().encode(images)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func removeImage(at offsets: IndexSet) {
        images.remove(offsets)
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(images.images.sorted()){image in
                        NavigationLink{
                            DetailedView(image: image, lat: image.latitude, long: image.longitude)
                        } label: {
                            HStack{
                                Image(uiImage: image.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                Text(image.name)
                                    .frame(alignment: .trailing)
                            }
                        }
                    }
                    .onDelete(perform: removeImage)
                }
            }
            .padding()
            .navigationTitle("ListYourPics")
            .toolbar{
                ToolbarItem{
                    NavigationLink{
                        AddView(images: images, curCoordinate: curLocation)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            self.locationFetcher.start()
            curLocation = self.locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var newPhoto = UserImage.example
        static var photos = [UserImage]()
        static var previews: some View {
            ContentView()
        }
    }
}

