//
//  APILive+GetLocations.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

@_exported import API
import Common
import Foundation

extension API.GetLocations {
    public static let live = Self { urlSession in
        let urlSession = urlSession ?? .shared
        let (data, response) = try await urlSession.data(from: .app.locations)
        guard let response = response as? HTTPURLResponse else {
            throw API.Error.response(response)
        }
        // A proper networking library would handle a lot more than just checking for a 200 status code but for simplicity sake (and to minimize depndencies) this is good enough for a coding challenge.
        guard response.statusCode == 200 else {
            throw API.Error.httpStatus(response.statusCode)
        }

        return try JSONDecoder().decode([Location].self, from: data)
    }
}
