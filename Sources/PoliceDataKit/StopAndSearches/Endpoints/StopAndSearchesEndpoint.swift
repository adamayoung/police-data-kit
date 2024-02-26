//
//  StopAndSearchesEndpoint.swift
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

enum StopAndSearchesEndpoint {

    case stopAndSearchesByAreaAtSpecificPoint(coordinate: CLLocationCoordinate2D, date: Date)
    case stopAndSearchesByAreaInArea(coordinates: [CLLocationCoordinate2D], date: Date)
    case stopAndSearchesAtLocation(streetID: Int, date: Date)
    case stopAndSearchesWithNoLocation(policeForceID: PoliceForce.ID, date: Date)
    case stopAndSearchesByPoliceForce(policeForceID: PoliceForce.ID, date: Date)

}

extension StopAndSearchesEndpoint: Endpoint {

    private static let basePath = URL(string: "/")!
    private static let stopsStreetBasePath = URL(string: "/stops-street")!
    private static let stopsAtLocationBasePath = URL(string: "/stops-at-location")!
    private static let stopsNoLocationBasePath = URL(string: "/stops-no-location")!
    private static let stopsForceBasePath = URL(string: "/stops-force")!

    var path: URL {
        switch self {
        case let .stopAndSearchesByAreaAtSpecificPoint(coordinate, date):
            Self.stopsStreetBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case let .stopAndSearchesByAreaInArea(coordinates, date):
            Self.stopsStreetBasePath
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case let .stopAndSearchesAtLocation(streetID, date):
            Self.stopsAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case let .stopAndSearchesWithNoLocation(policeForceID, date):
            Self.stopsNoLocationBasePath
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)

        case let .stopAndSearchesByPoliceForce(policeForceID, date):
            Self.stopsForceBasePath
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)
        }
    }

}
