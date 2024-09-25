//
//  API.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Foundation

public enum API {
    enum Error: Swift.Error {
        case httpStatus(Int)
        case response(URLResponse)
    }
}
