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
                return try JSONDecoder().decode([Location].self, from: defaultJSONData)
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

private let defaultJSONData: Data = Data(defaultJSONString.utf8)
// The first 6 values are grabbed because they contain 1 of each type to ensure filtering works in previews without doing API requests
private let defaultJSONString = """
[
    {
        "id": 1,
        "latitude": 37.7750,
        "longitude": -122.4195,
        "attributes": [
            {
                "type": "location_type",
                "value": "restaurant"
            },
            {
                "type": "name",
                "value": "Golden Gate Grill"
            },
            {
                "type": "description",
                "value": "A popular eatery with views of the bay."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 10.5
            }
        ]
    },
    {
        "id": 2,
        "latitude": 37.7745,
        "longitude": -122.4189,
        "attributes": [
            {
                "type": "location_type",
                "value": "museum"
            },
            {
                "type": "name",
                "value": "San Francisco Museum of Modern Art"
            },
            {
                "type": "description",
                "value": "Contemporary art exhibits."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 5.0
            }
        ]
    },
    {
        "id": 3,
        "latitude": 37.7752,
        "longitude": -122.4198,
        "attributes": [
            {
                "type": "location_type",
                "value": "park"
            },
            {
                "type": "name",
                "value": "Yerba Buena Gardens"
            },
            {
                "type": "description",
                "value": "Urban park with sculptures and waterfalls."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 8.0
            }
        ]
    },
    {
        "id": 4,
        "latitude": 37.7740,
        "longitude": -122.4200,
        "attributes": [
            {
                "type": "location_type",
                "value": "landmark"
            },
            {
                "type": "name",
                "value": "Transamerica Pyramid"
            },
            {
                "type": "description",
                "value": "Iconic skyscraper in the Financial District."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 12.3
            }
        ]
    },
    {
        "id": 5,
        "latitude": 37.7748,
        "longitude": -122.4185,
        "attributes": [
            {
                "type": "location_type",
                "value": "cafe"
            },
            {
                "type": "name",
                "value": "Union Square Cafe"
            },
            {
                "type": "description",
                "value": "Cozy cafe in the heart of downtown."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 3.7
            }
        ]
    },
    {
        "id": 6,
        "latitude": 37.7760,
        "longitude": -122.4170,
        "attributes": [
            {
                "type": "location_type",
                "value": "bar"
            },
            {
                "type": "name",
                "value": "The Tipsy Albatross"
            },
            {
                "type": "description",
                "value": "Lively bar with craft beers."
            },
            {
                "type": "estimated_revenue_millions",
                "value": 6.2
            }
        ]
    }
]
"""
