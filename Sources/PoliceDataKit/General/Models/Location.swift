//
//  Location.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreLocation
import Foundation

///
/// A model representing a location.
///
public struct Location: Equatable, Codable {

    /// An approximate street for the location.
    ///
    /// This is only an approximation of where the crime happened.
    public let street: Street

    /// Location coordinate.
    public let coordinate: CLLocationCoordinate2D?

    ///
    /// Creates a location object.
    ///
    /// - Parameters:
    ///   - street: An approximate street for the location.
    ///   - coordinate: Location coordinate.
    ///
    public init(street: Street, coordinate: CLLocationCoordinate2D) {
        self.street = street
        self.coordinate = coordinate
    }

}

public extension Location {

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case street
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let latitudeString = try container.decodeIfPresent(String.self, forKey: .latitude)
        let longitudeString = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.coordinate = {
            guard
                let latitudeString,
                let longitudeString,
                let latitude = Double(latitudeString),
                let longitude = Double(longitudeString)
            else {
                return nil
            }

            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }()

        self.street = try container.decode(Street.self, forKey: .street)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let latitudeString: String? = {
            guard let coordinate else {
                return nil
            }

            return String(coordinate.latitude)
        }()

        let longitudeString: String? = {
            guard let coordinate else {
                return nil
            }

            return String(coordinate.longitude)
        }()

        try container.encodeIfPresent(latitudeString, forKey: .latitude)
        try container.encodeIfPresent(longitudeString, forKey: .latitude)
        try container.encode(street, forKey: .street)
    }

}
