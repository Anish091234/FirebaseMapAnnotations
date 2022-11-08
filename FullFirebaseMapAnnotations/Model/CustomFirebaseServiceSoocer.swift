//
//  CustomFirebaseServiceSoocer.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 11/7/22.
//

import Foundation
import Firebase
import FirebaseFirestore

struct CustomFirestoreServiceSoccer {
    let store: Firestore = .firestore()
    init(){}
    func getAnnotations() async throws -> [Annotation]{
        let ANNOTATIONS_PATH = "annotations"
        return try await retrieve(path: ANNOTATIONS_PATH)
    }
    ///retrieves all the documents in the collection at the path
    private func retrieve<FC : Codable>(path: String) async throws -> [FC]{
        //Firebase provided async await.
        let querySnapshot = try await store.collection(path).whereField("sport", isEqualTo: "soccer").getDocuments()
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
