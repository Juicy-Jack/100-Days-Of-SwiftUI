//
//  AddView.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 16.07.2023.
//

import SwiftUI
import CoreLocation

struct AddView: View {
    @StateObject var images: Images
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var name = ""
    @State private var longitude = -122.0089189
    @State private var latitude = 37.3347302
    var curCoordinate: CLLocationCoordinate2D
    

    var body: some View {

        NavigationView {
            Form {
                Section {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                        
                        Text("Tap to select an image")
                            .foregroundColor(.white)
                            .font(.headline)
                        if inputImage != nil{
                            Image(uiImage: inputImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .frame(height: 400, alignment: .top )
                .onTapGesture {
                    showingImagePicker = true
                }
            
                Section{
                    TextField("Name", text: $name)
                }header: {
                    Text("Name the image")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                    .padding()
                
            }
            .toolbar{
                ToolbarItem{
                    Button("Add"){
                        images.addImage(name: name, image: inputImage!, latitude: curCoordinate.latitude, longitude: curCoordinate.longitude)
                        
                        inputImage = nil
                        name = ""
                    }
                    .disabled(inputImage == nil || name == "")
                }
            }
            .navigationTitle("Add an image")
        }
        .sheet(isPresented: $showingImagePicker){
            ImagePicker(image: $inputImage)
        }       
        }
}
/*
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
*/
