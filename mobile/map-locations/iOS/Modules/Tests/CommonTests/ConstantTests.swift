//
//  ConstantTests.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Common
import Foundation
import Testing

@Test("""
Ensure that we don't crash when getting the locations URL since it is hardcoded and force unwrapped.
For production level code using a proper #URL macro that validates it at compilation time would be better but I am trying to keep dependencies to a minimum for this coding challenge.
""")
func locationsURLIsValid() {
    let url = URL.app.locations
    #expect(!url.absoluteString.isEmpty)
}
