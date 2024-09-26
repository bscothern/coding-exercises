//
//  APILiveTests.swift
//  Modules
//
//  Created by Braden Scothern on 9/25/24.
//

import APILive
import Common
import Foundation
import Testing

// Normally you don't have a lot of tests for live APIs because a backend team owns them.
// But because I allready wrote them while ensuring I could encode/decode the JSON I have left them here.
// Normally the encoding/decoding isn't a thing needing tests like this if you are using API generation tools.
@Suite
struct APILiveTests {
    let api = API.GetLocations.live
    
    @Test
    func getLocationsData() async throws {
        let response = try await api.get()
        #expect(!response.isEmpty)
    }

    @Test
    func decodeLocations() async throws {
        let locations = try await api.get()
        #expect(locations.count == 45)
    }

    @Test
    func decodeEncodeDecode() async throws {
        let locations = try await api.get()
        let encoded = try JSONEncoder().encode(locations)
        let decoded = try JSONDecoder().decode([Location].self, from: encoded)
        #expect(locations == decoded)
    }
}
