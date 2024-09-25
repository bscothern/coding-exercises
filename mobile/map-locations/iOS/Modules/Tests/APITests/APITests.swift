//
//  APITests.swift
//  Modules
//
//  Created by Braden Scothern on 9/25/24.
//

import API
import Foundation
import Testing

@Suite
struct APITests {
    @Test
    func getLocationsData() async throws {
        let response = try await API.getLocationsData()
        #expect(!response.isEmpty)
    }
}
