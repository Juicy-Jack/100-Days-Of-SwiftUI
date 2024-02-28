//
//  DetailedView.swift
//  ListYourPics
//
//  Created by Furkan Doğan on 20.09.2023.
//

import SwiftUI
import MapKit

struct DetailedView: View {
    var image: UserImage
    var lat: Double
    var long: Double
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    var body: some View {
        NavigationView {
            VStack{
                Image(uiImage: image.image)
                    .resizable()
                    .scaledToFit()
                Text(image.name) 
            
                Map(coordinateRegion: $mapRegion, annotationItems: [image]){ image in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: image.latitude, longitude: image.longitude))
                }
            }
            .onAppear {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
                print("\(lat), \(long)")
            }
        }
        
    }
}
/*
struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView()
    }
}
*/
