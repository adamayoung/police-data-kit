//
//  OutcomesEndpoint.swift
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

enum OutcomesEndpoint {

    case streetLevelOutcomesForStreet(streetID: Int, date: Date)
    case streetLevelOutcomesAtSpecificPoint(coordinate: CLLocationCoordinate2D, date: Date)
    case streetLevelOutcomesInArea(coordinates: [CLLocationCoordinate2D], date: Date)
    case caseHistory(crimeID: String)

}

extension OutcomesEndpoint: Endpoint {

    private static let outcomesAtLocationBasePath = URL(string: "/outcomes-at-location")!
    private static let outcomesForCrimeBasePath = URL(string: "/outcomes-for-crime")!

    var path: URL {
        switch self {
        case let .streetLevelOutcomesForStreet(streetID, date):
            Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case let .streetLevelOutcomesAtSpecificPoint(coordinate, date):
            Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case let .streetLevelOutcomesInArea(coordinates, date):
            Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case let .caseHistory(crimeID):
            Self.outcomesForCrimeBasePath
                .appendingPathComponent("\(crimeID)")
        }
    }

}
