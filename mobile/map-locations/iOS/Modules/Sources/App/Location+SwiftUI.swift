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
    @MainActor
    var marker: some MapContent {
        let coordinates = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        
        let systemImage: String = switch locationType {
        case .restaurant:
            "fork.knife"
        case .bar:
            "wineglass.fill"
        case .park:
            "tree.fill"
        case .museum:
            "building.columns.fill"
        case .landmark:
            "star.fill"
        case .cafe:
            "cup.and.saucer.fill"
        case .other:
            "mappin"
        }
        
        return Marker(
            name,
            systemImage: systemImage,
            coordinate: coordinates
        )
        .tag(id)
    }
}
