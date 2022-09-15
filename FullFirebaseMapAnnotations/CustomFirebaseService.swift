//
//  CustomFirebaseService.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 9/11/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import CoreLocation
//struct to keep the latitude and longitude together, they should not be in separate arrays
struct Annotation: Codable, Identifiable{
    @DocumentID var id: String?
    var lat: String?
    var lng: String?
}
extension Annotation{
    //Safely unwrap the Strings into doubles and then create the coordinate
    var coordinate: CLLocationCoordinate2D? {
        guard let latStr = lat, let lngStr = lng, let latitude = Double(latStr), let longitude = Double(lngStr) else{
            print("Unable to get valid latitude and longitude")
            return nil
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)   
        return coordinate
        
    }
}

struct CustomFirestoreService{
    let store: Firestore = .firestore()
    init(){}
    func getAnnotations() async throws -> [Annotation]{
        let ANNOTATIONS_PATH = "annotations"
        return try await retrieve(path: ANNOTATIONS_PATH)
    }
    ///retrieves all the documents in the collection at the path
    private func retrieve<FC : Codable>(path: String) async throws -> [FC]{
        //Firebase provided async await.
        let querySnapshot = try await store.collection(path).getDocuments()
        return querySnapshot.documents.compactMap { document in
            do{
                return try document.data(as: FC.self)
            }catch{
                print(error)
                return nil
            }
        }
    }
}
