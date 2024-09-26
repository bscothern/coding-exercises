//
//  MapMode.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Foundation
import MapKit
import SwiftUI

enum MapMode: CaseIterable, Identifiable {
    case standard
    case hybrid
    case satellite

    var id: Self { self }
    
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
    
    func style(elevated: Bool) -> MapStyle {
        switch self {
        case .standard:
            return .standard(elevation: elevated ? .realistic : .flat)
        case .hybrid:
            return .hybrid(elevation: elevated ? .realistic : .flat)
        case .satellite:
            return .imagery(elevation: elevated ? .realistic : .flat)
        }
    }
}
