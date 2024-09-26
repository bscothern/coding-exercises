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
    
    func startLoadingFrom(
        api: API.GetLocations
    ) async {
        do {
            locations = try await api.get()
        } catch {
            loadingError = error
        }
    }
}
