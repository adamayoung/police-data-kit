//
//  NeighbourhoodsEndpointTests.swift
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
@testable import PoliceDataKit
import XCTest

final class NeighbourhoodsEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() throws {
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/neighbourhoods"))

        let path = NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() throws {
        let id = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(id)"))

        let path = NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testBoundaryEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/boundary"))

        let path = NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testTeamEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/people"))

        let path = NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testPrioritiesEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/priorities"))

        let path = NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testLocateNeighbourhoodReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let expectedPath = try XCTUnwrap(URL(
            string: "/locate-neighbourhood?q=\(coordinate.latitude),\(coordinate.longitude)"
        ))

        let path = NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

}
