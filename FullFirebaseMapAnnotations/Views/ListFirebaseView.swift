//
//  ListFirebaseView.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 9/11/22.
//

import SwiftUI
import Firebase
import MapKit

struct ListFirebaseView: View {
    // Refrence to get the annotations
    let service: CustomFirestoreService = CustomFirestoreService()
    let soccerService: CustomFirestoreServiceSoccer = CustomFirestoreServiceSoccer()
    @State var annotations: [Annotation] = []
    
    // Map Regions
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    @State var text = ""
    
    // City Annotations
    var body: some View {
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
            NavigationView {
                ZStack {
                    Map(coordinateRegion: $region, annotationItems: annotations) { place in
                        MapAnnotation(coordinate: place.coordinate!) {
                            NavigationLink {
                                LocationDetailsView(place: place.name)
                            } label: {
                                PlaceAnnotationView(title: place.name)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    
                    HStack {
                        
                        TextField("enter search term", text: $text)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                        
                        Button {
                            filter(filter: text)
                        } label: {
                            Text("Soccer")
                        }.buttonStyle(BorderedButtonStyle())
                    }
                }
            }
        }
    }
    
    func filter(filter: String) {
        if filter.lowercased() == "soccer" {
            Task {
                annotations = try await soccerService.getAnnotations()
            }
        }
    }
}
