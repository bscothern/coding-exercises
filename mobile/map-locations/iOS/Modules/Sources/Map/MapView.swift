//
//  MapView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import FilterPins
import LocationDetail
import MapKit
import Resources
import SwiftUI
import ViewModifiers

public struct MapView: View {
    @State
    private var viewModel: MapViewModel = .init()
    
    @Environment(\.apiGetLocations)
    private var api
    
    public var body: some View {
        GeometryReader { geomemtry in
            Group {
                GeometryReader { geometry in
                    VStack {
                        Group {
                            if let locations = viewModel.locations {
                                mainView(locations: locations)
                            } else {
                                loadingView
                            }
                        }
                        .frame(height: geometry.size.height * 0.75)
                        
                        lowerSection
                    }
                }
            }
            .task { [viewModel] in
                // Comment this out to simulate slow loading of the API data
                //            try! await Task.sleep(for: .seconds(3))
                await viewModel.startLoadingFrom(api: api)
            }
            .vceBackground()
            .sheet(
                item: $viewModel.showingSheet
            ) { showingSheet in
                sheet(for: showingSheet, in: geomemtry)
            }
        }
    }
    
    @ViewBuilder
    func mainView(locations: [Location]) -> some View {
        Map(selection: $viewModel.selectedPinID) {
            ForEach(locations) { location in
                location.marker
            }
        }
        .mapStyle(
            viewModel.mapMode.style(
                realisticElevation: viewModel.enableRealisticElevation
            )
        )
        .onChange(of: viewModel.selectedPinID, initial: false) {
            if let id = viewModel.selectedPinID {
                viewModel.showingSheet = .detailView(id: id)
            }
        }
    }

    @ViewBuilder
    var loadingView: some View {
        VStack {
            Text("MAP_VIEW.LOADING", bundle: .package)
            ProgressView()
        }
    }

    @ViewBuilder
    var lowerSection: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                let gridItem = GridItem(.flexible(minimum: geometry.size.width * 0.1, maximum: geometry.size.width * 0.4))
                LazyVGrid(
                    columns: Array(repeating: gridItem, count: 2),
                    alignment: .center
                ) {
                    HStack {
                        Spacer()
                        Text("MAP_VIEW.MAP_MODE_LABEL", bundle: .package)
                            .frame(alignment: .trailing)
                    }
                    Picker(
                        selection: $viewModel.mapMode
                    ) {
                        ForEach(MapMode.allCases) { mode in
                            // Since the mode has its localized string we don't need to or want to have Text look it up.
                            // Using Text(verbatim:) will just use the value it is provided without the extra lookups.
                            Text(verbatim: mode.localizedString)
                                .tag(mode)
                        }
                    } label: {
                        EmptyView()
                    }
                    HStack {
                        Spacer()
                            .frame(minWidth: 0, idealWidth: 0)
                            .background {
                                Color.red
                            }
                        Text("MAP_VIEW.ELEVATION_LABEL", bundle: .package)
                            .fixedSize() // Disables multiline and makes it take up all the sapce it is supposed to ignoring boundaries
                    }

                    Toggle(isOn: $viewModel.enableRealisticElevation) {
                        EmptyView()
                    }
                    .padding(.trailing)
                }
                .frame(width: geometry.size.width * 0.8)
                
                Button {
                    viewModel.filterPinsPressed()
                } label: {
                    Text("MAP_VIEW.FILTER_PINS", bundle: .package)
                }
                .buttonStyle(BorderedButtonStyle())
                
                Spacer()
            }
            .frame(width: geometry.size.width)
        }
    }

    @ViewBuilder
    func sheet(for showingSheet: MapViewModel.Sheet, in geometry: GeometryProxy) -> some View {
        switch showingSheet {
        case .filterPins:
            FilterPinsView(filter: $viewModel.locationsFilter)
        case let .detailView(id):
            if let location = viewModel.location(id: id) {
                LocationDetailView(
                    for: location,
                    selected: $viewModel.selectedPinID
                )
            } else {
                // This should never happen but it will ensure that the UI doesn't end up in a weird state if it somehow were to trigger.
                // The worse case is that the details wouldn't show up.
                // In a full app you would want an analytic event here to let you know that something you expect to never happen has happened and you would provide enough details to hopefully reproduce the issue and prevent it in the future.
                Color.clear
                    .onAppear {
                        viewModel.showingSheet = nil
                    }
            }
        }
    }

    public init() {}
}


#Preview {
    MapView()
}
