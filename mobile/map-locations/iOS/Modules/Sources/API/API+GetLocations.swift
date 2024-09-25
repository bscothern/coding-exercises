//
//  API+GetLocations.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import Foundation

extension API {
    public static func getLocationsData(urlSession: URLSession = .shared) async throws -> Data {
        let (data, response) = try await urlSession.data(from: .app.locations)
        guard let response = response as? HTTPURLResponse else {
            throw API.Error.response(response)
        }
        guard response.statusCode == 200 else {
            throw API.Error.httpStatus(response.statusCode)
        }
        return data
    }
}
