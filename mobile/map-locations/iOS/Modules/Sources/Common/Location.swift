//
//  Location.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

public struct Location: Hashable, Sendable, Identifiable, Codable {
    public var id: Int
    public var latitude: Double
    public var longitude: Double
    // Attributes
    public var locationType: String
    public var name: String
    public var description: String
    public var estimatedMillionsInRevenue: Double

    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case attributes
    }

    // Because Type is a special keyword in swift it can't be used as a type name even with backticks like other keywords.
    // It will break all sorts of things
    enum AttributeType: String, CodingKey, Codable {
        case locationType = "location_type"
        case name
        case description
        case estimatedMillionsInRevenue = "estimated_revenue_millions"
    }

    struct Attribute: Codable {
        var type: AttributeType
        var value: Value

        // This enum lets you abstract away all the pain of having the value be a string or double to pretty much just this one spot.
        // This is how most auto generated API handles cases of Either values.
        enum Value: Codable {
            case string(String)
            case double(Double)

            var stringValue: String? {
                switch self {
                case let .string(value):
                    return value
                case .double:
                    return nil
                }
            }

            var doubleValue: Double? {
                switch self {
                case let .double(value):
                    return value
                case .string:
                    return nil
                }
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                if let stringValue = try? container.decode(String.self) {
                    self = .string(stringValue)
                } else if let doubleValue = try? container.decode(Double.self) {
                    self = .double(doubleValue)
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected String or Double for attribute value")
                }
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case let .string(value):
                    try container.encode(value)
                case let .double(value):
                    try container.encode(value)
                }
            }
        }
    }

    public init(id: Int, latitude: Double, longitude: Double, locationType: String, name: String, description: String, estimatedMillionsInRevenue: Double) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.locationType = locationType
        self.name = name
        self.description = description
        self.estimatedMillionsInRevenue = estimatedMillionsInRevenue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        let attributes = try container.decode([Attribute].self, forKey: .attributes)

        var locationType: String?
        var name: String?
        var description: String?
        var estimatedMillionsInRevenue: Double?

        for attribute in attributes {
            switch attribute.type {
            case .locationType:
                locationType = attribute.value.stringValue
            case .name:
                name = attribute.value.stringValue
            case .description:
                description = attribute.value.stringValue
            case .estimatedMillionsInRevenue:
                estimatedMillionsInRevenue = attribute.value.doubleValue
            }
        }

        guard let locationType else {
            throw DecodingError.dataCorruptedError(forKey: .attributes, in: container, debugDescription: "Expected to find attribute \(AttributeType.locationType.rawValue) and its value")
        }
        self.locationType = locationType

        guard let name else {
            throw DecodingError.dataCorruptedError(forKey: .attributes, in: container, debugDescription: "Expected to find attribute \(AttributeType.name.rawValue) and its value")
        }
        self.name = name

        guard let description else {
            throw DecodingError.dataCorruptedError(forKey: .attributes, in: container, debugDescription: "Expected to find attribute \(AttributeType.description.rawValue) and its value")
        }
        self.description = description

        guard let estimatedMillionsInRevenue else {
            throw DecodingError.dataCorruptedError(forKey: .attributes, in: container, debugDescription: "Expected to find attribute \(AttributeType.estimatedMillionsInRevenue.rawValue) and its value")
        }
        self.estimatedMillionsInRevenue = estimatedMillionsInRevenue
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        let attriubtes: [Attribute] = [
            Attribute(type: .locationType, value: .string(locationType)),
            Attribute(type: .name, value: .string(name)),
            Attribute(type: .description, value: .string(description)),
            Attribute(type: .estimatedMillionsInRevenue, value: .double(estimatedMillionsInRevenue))
        ]
        try container.encode(attriubtes, forKey: .attributes)
    }
}
