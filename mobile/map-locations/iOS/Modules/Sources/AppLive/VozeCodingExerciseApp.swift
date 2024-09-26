//
//  VozeCodingExerciseApp.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import App
import APILive
import SwiftUI

@main
struct VozeCodingExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.apiGetLocations, .live)
        }
    }
}
