//
//  ListFirebaseView.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 9/11/22.
//

import SwiftUI
import Firebase
import MapKit

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ListFirebaseView: View {
    // Refrence to get the annotations
    let service: CustomFirestoreService = CustomFirestoreService()
    @State var annotations: [Annotation] = []
    
    // Map Regions
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    @State var cityLat = 0.0
    @State var cityLng = 0.0
    
    // City Annotations
    var body: some View {
        
        var cityAnnotations = [
            City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
            City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
            City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        ]
        
        if annotations.isEmpty{
            Text("Need to fetch annotations")
                .task {
                    do{
                        annotations = try await service.getAnnotations()
                        //Do any other work here, this line won't run unless the annotations are populated.
                    }catch{
                        print(error)
                    }
                }
        } else {
            VStack {
                
                ///How to list all of the saved annotations inside of the database
                //List(annotations){ annotation in
                //    if let coord = annotation.coordinate{
                //        VStack{
                //            Text("Latitude = \(coord.latitude)")
                //            Text("Longitude = \(coord.longitude)")
                //        }
                //    }else {
                //        Text("Invalid Coordinate Value. Check firestore values for document \(annotation.id ?? "no id")")
                //    }
                //}
                
                ///Attempting to create the annotations
                ForEach(annotations) { annotation in
                    VStack {
                        Text(annotation.lat ?? "")
                        Text(annotation.lng ?? "")
                    }
                    Button {
                        // Adds the annotion to cityAnnotation
                        cityAnnotations.append(City(name: "Annotation", coordinate: annotation.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)))
                        
                        
                        print(" ------------ CityAnnotations after adding the ones inside of Firebase \(cityAnnotations) -------")
                    } label: {
                        Text("Convert and Send!")
                    }

                }
                Map(coordinateRegion: $region, annotationItems: cityAnnotations) {
                    MapPin(coordinate: $0.coordinate)
                }
                .ignoresSafeArea()
                
                Button {
                    print(cityAnnotations)
                } label: {
                    Text("Press me for the thingy")
                }
                .buttonStyle(BorderedButtonStyle())
            }
        }
    }
}

struct ListFirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        ListFirebaseView()
    }
}
