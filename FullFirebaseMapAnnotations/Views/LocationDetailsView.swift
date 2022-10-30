//
//  LocationDetailsView.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 10/29/22.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
  let place: String
  
  var body: some View {
    VStack(spacing: 20) {
      Text(place)
        .font(.title)
    }
    .navigationTitle(place)
  }
}

