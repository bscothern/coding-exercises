//
//  Location+SwiftUI.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Common
import MapKit
import SwiftUI

extension Location {
    /// The pin of the map content tagged by its ID.
    @MainActor
    var marker: some MapContent {
        let coordinates = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )

        return Marker(
            name,
            systemImage: locationType.caseValue.systemImage,
            coordinate: coordinates
        )
        .tag(id)
    }
}
