//
//  Constant.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Foundation

public enum Constant {}

extension Constant {
    public enum AppURL {
        public static let locations = URL(string: "https://raw.githubusercontent.com/bscothern/voze-coding-exercises/refs/heads/master/mobile/map-locations/locations.json")!
    }
}
