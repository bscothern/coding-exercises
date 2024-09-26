//
//  MapView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import MapKit
import Resources
import SwiftUI

public struct MapView: View {
    @State
    private var viewModel: MapViewModel = .init()
    
    @Environment(\.apiGetLocations)
    private var api
    
    public var body: some View {
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
        .background {
            // This adds a tiled image to the background of everything with just a bit of opacity so it adds some texture.
            // This makes it feel a little off from just standard cookie cutter UI and can add some ni
            Image("Background", bundle: .package)
                .resizable(resizingMode: .tile)
                .opacity(0.2)
                .ignoresSafeArea()
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
                elevated: viewModel.enableElevation
            )
        )
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
                
                let gridItem = GridItem(.flexible(minimum: geometry.size.width * 0.1, maximum: geometry.size.width * 0.3))
                LazyVGrid(
                    columns: Array(repeating: gridItem, count: 2),
                    alignment: .center
                ) {
                    Text("MAP_VIEW.MAP_MODE_LABEL", bundle: .package)
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
                    Text("MAP_VIEW.ELEVATION_LABEL", bundle: .package)
                    HStack {
                        Toggle(isOn: $viewModel.enableElevation) {
                            EmptyView()
                        }
                        .padding(.horizontal)
                    }
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
    
    public init() {}
}

#Preview {
    MapView()
}
