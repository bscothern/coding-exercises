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
    var selectedPin: Int?
    
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
