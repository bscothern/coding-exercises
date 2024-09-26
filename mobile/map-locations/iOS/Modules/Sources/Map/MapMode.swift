//
//  MapMode.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Foundation
import MapKit
import SwiftUI

/// The different ways you can present the map content
enum MapMode: CaseIterable, Identifiable {
    /// A standard flat version of the map.
    case standard
    /// A satelite view with extra annotations that are present on the standard view but not satellite.
    case hybrid
    /// A satellite view of the map.
    case satellite

    var id: Self { self }
    
    /// The localized string describing the `MapMode`
    var localizedString: String {
        switch self {
        case .standard:
            String(localized: "MAP_MODE.STANDARD", bundle: .package)
        case .hybrid:
            String(localized: "MAP_MODE.HYBRID", bundle: .package)
        case .satellite:
            String(localized: "MAP_MODE.SATELLITE", bundle: .package)
        }
    }
    
    /// The `MapStyle` representation of this `MapMode`
    /// - Parameter realisticElevation: If `true` then elevations will be drawn more realistic, otherwise they will be drawn more flat.
    /// - Returns: The `MapStyle` represetnation of the `MapMode`
    func style(realisticElevation: Bool) -> MapStyle {
        switch self {
        case .standard:
            return .standard(elevation: realisticElevation ? .realistic : .flat)
        case .hybrid:
            return .hybrid(elevation: realisticElevation ? .realistic : .flat)
        case .satellite:
            return .imagery(elevation: realisticElevation ? .realistic : .flat)
        }
    }
}
