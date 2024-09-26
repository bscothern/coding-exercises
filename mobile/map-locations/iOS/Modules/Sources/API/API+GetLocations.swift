//
//  API+GetLocations.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import Foundation
import SwiftUI

extension API {
    // This lets me do some simple dependency injection for the API call.
    // This is important in a real app in order for tests and previews to be able to run without hitting real API endpoints.
    // This means the default provides some simple mock data and the live value that is injected at actual start up of the app does proper networking.
    // See VozeCodingExerciseApp.swift for the injection of the live value and APILive+GetLocations for the live implimentation.
    // The reason the live implementation is not here is that it can theoretically have other dependencies that might be expensive to build do its job.
    // By having it separated out everything else can always build fast when doing normal development and only when you need the real value do you get the cost of building it all.
    public struct GetLocations: EnvironmentKey, Sendable {
        public typealias GetFunction = @Sendable (_ urlSession: URLSession?) async throws -> [Location]
        
        public static let defaultValue: Self = .init(
            get: { _ in
                return [
                    .init(
                        id: 1,
                        latitude: 37.7750,
                        longitude: -122.4195,
                        locationType: .restaurant,
                        name: "Golden Gate Grill",
                        description: "A popular eatery with views of the bay.",
                        estimatedMillionsInRevenue: 10.5
                    ),
                    .init(
                        id: 2,
                        latitude: 37.7745,
                        longitude: -122.4189,
                        locationType: .museum,
                        name: "San Francisco Museum of Modern Art",
                        description: "Contemporary art exhibits.",
                        estimatedMillionsInRevenue: 5.0
                    )
                ]
            }
        )
        
        public let get: GetFunction
        
        public func get() async throws -> [Location] {
            try await self.get(nil)
        }
        
        public init(
            get: @escaping GetFunction
        ) {
            self.get = get
        }
    }
}

extension EnvironmentValues {
    public var apiGetLocations: API.GetLocations {
        get { self[API.GetLocations.self] }
        set { self[API.GetLocations.self] = newValue }
    }
}
