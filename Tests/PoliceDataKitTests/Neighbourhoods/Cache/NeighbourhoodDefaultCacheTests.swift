//
//  NeighbourhoodDefaultCacheTests.swift
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
import Testing

@Suite("NeighbourhoodDefaultCache")
struct NeighbourhoodDefaultCacheTests {

    let cache: NeighbourhoodDefaultCache
    let cacheStore: MockCache

    init() {
        self.cacheStore = MockCache()
        self.cache = NeighbourhoodDefaultCache(cacheStore: cacheStore)
    }

    @Test("neighbourhoods in police force when miss returns nil")
    func neighbourhoodsInPoliceForceWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let result = await cache.neighbourhoods(inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("neighbourhoods in police force when hit returns neighbour references")
    func neighbourhoodsInPoliceForceWhenHitReturnsNeighbourReferences() async {
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReference.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.neighbourhoods(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("neighbourhoods in police force sets neighbourhoods")
    func neighbourhoodsInPoliceForceSetsNeighbourhoods() async {
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReference.mocks

        await cache.setNeighbourhoods(expectedResult, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [NeighbourhoodReference].self)

        #expect(result == expectedResult)
    }

    @Test("neighbourhood when miss returns nil")
    func neighbourhoodWhenMissReturnsNil() async {
        let id = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let result = await cache.neighbourhood(withID: id, inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("neighbourhood when hit returns neighbour")
    func neighbourhoodWhenHitReturnsNeighbour() async {
        let id = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        let expectedResult = Neighbourhood.mock
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.neighbourhood(withID: id, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set neighbourhood sets neighbourhood")
    func setNeighbourhoodSetsNeighbourhood() async {
        let id = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        let expectedResult = Neighbourhood.mock

        await cache.setNeighbourhood(expectedResult, withID: id, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: Neighbourhood.self)

        #expect(result == expectedResult)
    }

    @Test("boundary for neighbourhood when miss returns nil")
    func boundaryForNeighbourhoodWhenMissReturnsNil() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let result = await cache.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("boundary for neighbourhood when hit returns boundary")
    func boundaryForNeighbourhoodWhenHitReturnsBoundary() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let expectedResult = CLLocationCoordinate2D.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set boundary for neighbourhood sets boundary")
    func setBoundaryForNeighbourhoodSetsBoundary() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let expectedResult = CLLocationCoordinate2D.mocks

        await cache.setBoundary(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [CLLocationCoordinate2D].self)

        #expect(result == expectedResult)
    }

    @Test("police officers for neighbourhood when miss returns nil")
    func policeOfficersForNeighbourhoodWhenMissReturnsNil() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let result = await cache.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("police officers for neighbourhood when hit returns police officers")
    func policeOfficersForNeighbourhoodWhenHitReturnsPoliceOfficers() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID,
            policeForceID: policeForceID
        )
        let expectedResult = PoliceOfficer.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set police officers for neighbourhood sets police officers")
    func setPoliceOfficersForNeighbourhoodSetsPoliceOfficers() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID,
            policeForceID: policeForceID
        )
        let expectedResult = PoliceOfficer.mocks

        await cache.setPoliceOfficers(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [PoliceOfficer].self)

        #expect(result == expectedResult)
    }

    @Test("priorities for neighbourhood when miss returns nil")
    func prioritiesForNeighbourhoodWhenMissReturnsNil() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let result = await cache.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("priorities for neighbourhood when hit returns priorities")
    func prioritiesForNeighbourhoodWhenHitReturnsPriorities() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodPrioritiesCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let expectedResult = NeighbourhoodPriority.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set priorities for neighbourhood sets police officers")
    func setPrioritiesForNeighbourhoodSetsPoliceOfficers() async {
        let neighbourhoodID = "test-neighbourhood"
        let policeForceID = "test-police-force"
        let cacheKey = NeighbourhoodPrioritiesCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let expectedResult = NeighbourhoodPriority.mocks

        await cache.setPriorities(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [NeighbourhoodPriority].self)

        #expect(result == expectedResult)
    }

}
