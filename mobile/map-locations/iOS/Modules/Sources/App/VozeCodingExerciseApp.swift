//
//  VozeCodingExerciseApp.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import APILive
import Map
import SwiftUI

@main
struct VozeCodingExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            MapView()
                .environment(\.apiGetLocations, .live)
        }
    }
}
