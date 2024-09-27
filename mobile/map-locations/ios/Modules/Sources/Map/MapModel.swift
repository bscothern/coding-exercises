//
//  MapModel.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import API
import Common
import IdentifiedCollections
import Observation

@Observable
final class MapModel {
    // Bindable
    var mapMode: MapMode = .standard
    var enableRealisticElevation = true
    var showingSheet: Sheet?
    var selectedPinID: Int?
    var locationsFilter: LocationTypeFilter = .all {
        didSet {
            updateLocations()
        }
    }

    // Not Bindable
    internal private(set) var loadingError: (any Error)?
    internal private(set) var activeFilters: LocationTypeFilter = []
    /// The locations that are accessible according to the `locationsFilter`
    internal private(set) var locations: [Location]?
    private var allLocations: IdentifiedArrayOf<Location>?

    internal private(set) var sheetContentHeight: Double = .infinity

    func location(id: Int) -> Location? {
        allLocations?[id: id]
    }

    func filterPinsPressed() {
        showingSheet = .filterPins
    }
    
    func updateLocations() {
        locations = allLocations?.filter {
            locationsFilter.contains($0.locationType.caseValue.filterValue)
        }
    }

    func startLoadingFrom(
        api: API.GetLocations
    ) async {
        do {
            let locations = try await api.get()
            allLocations = .init(
                locations,
                uniquingIDsWith: { first, _ in first }
            )
            for location in locations {
                activeFilters.insert(location.locationType.caseValue.filterValue)
            }
            updateLocations()
        } catch {
            loadingError = error
        }
    }

    func newSheetContentHeight(of height: Double) {
        self.sheetContentHeight = height
    }
}

extension MapModel {
    enum Sheet: Hashable, Sendable, Identifiable {
        case filterPins
        case detailView(id: Int)

        var id: Self { self }
    }
}
