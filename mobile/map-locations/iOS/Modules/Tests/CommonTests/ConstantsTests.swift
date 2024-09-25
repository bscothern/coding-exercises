//
//  ConstantsTests.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Testing
import Common

@Test("""
Ensure that we don't crash when getting the jsonURL since it is hardcoded.
For production level code using a proper #URL macro that validates it at compilation time would be better but I am trying to keep dependencies to a minimum for thos coding challenge.
""")
func jsonURLIsValid() {
    let url = Constants.jsonURL
    #expect(url.absoluteString == "https://raw.githubusercontent.com/bscothern/voze-coding-exercises/master/mobile/map-locations/locations.json")
}
