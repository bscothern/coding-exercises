//
//  Location+SwiftUI.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

#if canImport(SwiftUI)
import MapKit
import SwiftUI

extension Location {
    /// The pin of the map content tagged by its ID.
    @MainActor
    public var marker: some MapContent {
        let coordinates = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )

        return Marker(
            name,
            systemImage: locationType.caseValue.systemImage,
            coordinate: coordinates
        )
        .tint(locationType.caseValue.color)
        .tag(id)
    }
}

extension Location.LocationType.Cases {
    public var color: Color {
        switch self {
        case .restaurant:
            return .red
        case .bar:
            return .blue
        case .park:
            return .green
        case .museum:
            return .yellow
        case .landmark:
            return .purple
        case .cafe:
            return .orange
        case .other:
            return .cyan
        }
    }
}
#endif
