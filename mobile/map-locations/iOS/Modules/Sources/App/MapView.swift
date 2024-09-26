//
//  MapView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import MapKit
import SwiftUI
import Resources

public struct MapView: View {
    @State
    private var viewModel: MapViewModel = .init()
    
    @Environment(\.apiGetLocations)
    private var api
    
    public var body: some View {
        Group {
            if let locations = viewModel.locations {
                Map {
                    ForEach(locations) { location in
                        location.marker
                    }
                }
            } else {
                loadingView
            }
        }
        .task { [viewModel] in
//            try! await Task.sleep(for: .seconds(3))
            await viewModel.startLoadingFrom(api: api)
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        VStack {
            Text("MAP_VIEW.LOADING", bundle: .package)
            ProgressView()
        }
    }
    
    public init() {}
}

#Preview {
    MapView()
}
