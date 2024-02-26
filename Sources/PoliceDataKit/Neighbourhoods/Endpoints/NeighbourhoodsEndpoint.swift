//
//  NeighbourhoodsEndpoint.swift
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

enum NeighbourhoodsEndpoint {

    case list(policeForceID: PoliceForce.ID)
    case details(id: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case boundary(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case policeOfficers(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case priorities(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case locateNeighbourhood(coordinate: CLLocationCoordinate2D)

}

extension NeighbourhoodsEndpoint: Endpoint {

    private static let basePath = URL(string: "/")!

    var path: URL {
        switch self {
        case let .list(policeForceID):
            Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent("neighbourhoods")

        case let .details(id, policeForceID):
            Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(id)

        case let .boundary(neighbourhoodID, policeForceID):
            Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("boundary")

        case let .policeOfficers(neighbourhoodID, policeForceID):
            Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("people")

        case let .priorities(neighbourhoodID, policeForceID):
            Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("priorities")

        case let .locateNeighbourhood(coordinate):
            Self.basePath
                .appendingPathComponent("locate-neighbourhood")
                .appendingQueryItem(name: "q", coordinate: coordinate)
        }
    }

}
