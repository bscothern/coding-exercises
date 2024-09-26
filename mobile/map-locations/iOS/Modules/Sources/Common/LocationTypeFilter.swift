//
//  LocationTypeFilter.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

public struct LocationTypeFilter: OptionSet, Sendable {
    public let rawValue: Int

    public static let restaurant: Self = .init(rawValue: 1 << 0)
    public static let bar: Self = .init(rawValue: 1 << 1)
    public static let landmark: Self = .init(rawValue: 1 << 2)
    public static let museum: Self = .init(rawValue: 1 << 3)
    public static let cafe: Self = .init(rawValue: 1 << 4)
    public static let park: Self = .init(rawValue: 1 << 5)
    public static let other: Self = .init(rawValue: 1 << 6)
    
    public static let all: Self = [.restaurant, .bar, .landmark, .museum, .cafe, .park, .other]
    
    var locations: Set<Location.LocationType> {
        var locations: Set<Location.LocationType> = []
        if contains(.restaurant) {
            locations.insert(.restaurant)
        }
        
        if contains(.bar) {
            locations.insert(.bar)
        }
        
        if contains(.landmark) {
            locations.insert(.landmark)
        }
        
        if contains(.museum) {
            locations.insert(.museum)
        }
        
        if contains(.cafe) {
            locations.insert(.cafe)
        }
        
        if contains(.park) {
            locations.insert(.park)
        }

        if contains(.other) {
            locations.insert(.other(""))
        }
        
        return locations
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Location.LocationType.Cases {
    public var filterValue: LocationTypeFilter {
        switch self {
        case .restaurant:
            return .restaurant
        case .bar:
            return .bar
        case .landmark:
            return .landmark
        case .museum:
            return .museum
        case .cafe:
            return .cafe
        case .park:
            return .park
        case .other:
            return .other
        }
    }
}
