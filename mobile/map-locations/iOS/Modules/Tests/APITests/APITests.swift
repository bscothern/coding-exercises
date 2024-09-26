//
//  APITests.swift
//  Modules
//
//  Created by Braden Scothern on 9/25/24.
//

import API
import Common
import Foundation
import Testing

@Suite
struct APITests {
    @Test
    func getLocationsData() async throws {
        let response = try await API.getLocationsData()
        #expect(!response.isEmpty)
    }

    @Test
    func decodeLocations() async throws {
        let locations = try await API.getLocations()
        #expect(locations.count == 45)
    }

    @Test
    func decodeEncodeDecode() async throws {
        let locations = try await API.getLocations()
        let encoded = try JSONEncoder().encode(locations)
        let decoded = try JSONDecoder().decode([Location].self, from: encoded)
        #expect(locations == decoded)
    }
}
