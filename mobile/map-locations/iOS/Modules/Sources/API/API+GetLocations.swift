//
//  API+GetLocations.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import Foundation

extension API {
    public static func getLocations() async throws -> [Location] {
        let data = try await getLocationsData()
        return try JSONDecoder().decode([Location].self, from: data)
    }

    public static func getLocationsData(urlSession: URLSession = .shared) async throws -> Data {
        let (data, response) = try await urlSession.data(from: .app.locations)
        guard let response = response as? HTTPURLResponse else {
            throw API.Error.response(response)
        }
        // A proper networking library would handle a lot more than just checking for a 200 status code but for simplicity sake this is good enough for a coding challenge.
        guard response.statusCode == 200 else {
            throw API.Error.httpStatus(response.statusCode)
        }
        return data
    }
}
