//
//  MapViewModel.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import API
import Common
import Observation

@Observable
final class MapViewModel {
    var loadingError: (any Error)?
    var locations: [Location]?
    var selectedPinID: Int?
    var enableElevation: Bool = true
    var mapMode: MapMode = .standard
    
    func location(id: Int) -> Location? {
        // Lots of people don't know you can use labels with trailing closures when the functions have this pattern.
        // I find it helps new people coming into the code read it more easily since thing.first { ... } isn't always the most intuitive, especially to newer swift devs.
        locations?.first(where:) { $0.id == id }
    }
    
    func filterPinsPressed() {
        
    }

    func startLoadingFrom(
        api: API.GetLocations
    ) async {
        do {
            locations = try await api.get()
        } catch {
            // If you are getting a warning here then Xcode is lying.
            // For some reason it is triggering a false unreachable catch block.
            // Hopefully it is fixed in the next version of Xcode.
            loadingError = error
        }
    }
}
