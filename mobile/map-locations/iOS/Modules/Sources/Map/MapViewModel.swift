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
    // Bindable
    var mapMode: MapMode = .standard
    var enableRealisticElevation: Bool = true
    var showingSheet: Sheet?
    var selectedPinID: Int?
    var locationsFilter: LocationTypeFilter = .all
    
    // Not Bindable
    internal private(set) var loadingError: (any Error)?
    internal private(set) var rawLocations: [Location]?
    var locations: [Location]? {
        rawLocations?.filter {
            locationsFilter.contains($0.locationType.caseValue.filterValue)
        }
    }
    internal private(set) var sheetContentHeight: Double = .infinity
    
    func location(id: Int) -> Location? {
        // Lots of people don't know you can use labels with trailing closures when the functions have this pattern.
        // I find it helps new people coming into the code read it more easily since thing.first { ... } isn't always the most intuitive, especially to newer swift devs.
        rawLocations?.first(where:) { $0.id == id }
    }
    
    func filterPinsPressed() {
        showingSheet = .filterPins
    }

    func startLoadingFrom(
        api: API.GetLocations
    ) async {
        do {
            rawLocations = try await api.get()
        } catch {
            loadingError = error
        }
    }
    
    func newSheetContentHeight(of height: Double) {
        self.sheetContentHeight = height
    }
}


extension MapViewModel {
    enum Sheet: Hashable, Sendable, Identifiable {
        case filterPins
        case detailView(id: Int)
        
        var id: Self { self }
    }
}
