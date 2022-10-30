//
//  City.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 10/29/22.
//

import Foundation
import MapKit

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
