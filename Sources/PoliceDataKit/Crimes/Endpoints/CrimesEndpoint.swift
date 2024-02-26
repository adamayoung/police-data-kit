//
//  CrimesEndpoint.swift
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

enum CrimesEndpoint {

    case streetLevelCrimesAtSpecificPoint(coordinate: CLLocationCoordinate2D, date: Date)
    case streetLevelCrimesInArea(coordinates: [CLLocationCoordinate2D], date: Date)
    case crimesAtLocationForStreet(streetID: Int, date: Date)
    case crimesAtLocationAtSpecificPoint(coordinate: CLLocationCoordinate2D, date: Date)
    case crimesWithNoLocation(categoryID: CrimeCategory.ID, policeForceID: PoliceForce.ID, date: Date)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    private static let streetLevelCrimesAtLocationBasePath = URL(string: "/crimes-street")!
    private static let crimesAtLocationBasePath = URL(string: "/crimes-at-location")!
    private static let crimesWithNoLocationBasePath = URL(string: "/crimes-no-location")!
    private static let crimeCategoriesBasePath = URL(string: "/crime-categories")!

    var path: URL {
        switch self {
        case let .streetLevelCrimesAtSpecificPoint(coordinate, date):
            Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case let .streetLevelCrimesInArea(coordinates, date):
            Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case let .crimesAtLocationForStreet(streetID, date):
            Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case let .crimesAtLocationAtSpecificPoint(coordinate, date):
            Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case let .crimesWithNoLocation(categoryID, policeForceID, date):
            Self.crimesWithNoLocationBasePath
                .appendingQueryItem(name: "category", value: categoryID)
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)

        case let .categories(date):
            Self.crimeCategoriesBasePath
                .appendingQueryItem(name: "date", date: date)
        }
    }

}
