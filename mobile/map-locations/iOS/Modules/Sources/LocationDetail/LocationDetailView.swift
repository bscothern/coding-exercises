//
//  LocationDetailView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Common
import MapKit
import Resources
import SwiftUI
import ViewModifiers

public struct LocationDetailView: View {
    let location: Location

    @State
    var lookAroundScene: MKLookAroundScene?

    @Binding
    var selectedBinding: Int?

    public var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: location.locationType.caseValue.systemImage)
                    Text(verbatim: location.locationType.caseValue.localizedDescription)
                        .font(.caption)
                }
                .foregroundStyle(location.locationType.caseValue.color)
                Text(verbatim: location.name)
            }
            .font(.title2)

            Text(
                "LOCATION_DETAIL_ESTIMATED_REVENUE \(location.estimatedMillionsInRevenue.formatted(.currency(code: "USD")))",
                bundle: .package
            )
            Text(verbatim: location.description)
                .multilineTextAlignment(.center)

            lookAround
        }
        .padding()
        .presentationDetents([.fraction(0.4)])
        .onAppear {
            lookAroundScene = nil
            let coordinates = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )
            let request = MKLookAroundSceneRequest(coordinate: coordinates)
            // The async version is not marked as @MainActor but this callback version is ¯\_(ツ)_/¯
            // So instead of doing this in a .task modifier block we will do it like this
            request.getSceneWithCompletionHandler { scene, _ in
                lookAroundScene = scene
            }
        }
        .onDisappear {
            // Without the withAnimation block this just snaps back and feels/looks bad.
            withAnimation {
                selectedBinding = nil
            }
        }
        .vceBackground()
    }

    var lookAround: some View {
        LookAroundPreview(scene: $lookAroundScene)
    }

    public init(for location: Location, selected selectedBinding: Binding<Int?>) {
        self.location = location
        self._selectedBinding = selectedBinding
    }
}
