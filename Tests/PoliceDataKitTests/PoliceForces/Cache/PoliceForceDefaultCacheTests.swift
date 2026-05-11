//
//  PoliceForceDefaultCacheTests.swift
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

@testable import PoliceDataKit
import Testing

@Suite("PoliceForceDefaultCache")
struct PoliceForceDefaultCacheTests {

    let cache: PoliceForceDefaultCache
    let cacheStore: MockCache

    init() {
        self.cacheStore = MockCache()
        self.cache = PoliceForceDefaultCache(cacheStore: cacheStore)
    }

    @Test("police forces when miss returns nil")
    func policeForcesWhenMissReturnsNil() async {
        let result = await cache.policeForces()

        #expect(result == nil)
    }

    @Test("police forces when hit returns police forces")
    func policeForcesWhenHitReturnsPoliceForces() async {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.policeForces()

        #expect(result == expectedResult)
    }

    @Test("set police forces sets police forces")
    func setPoliceForcesSetsPoliceForces() async {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()

        await cache.setPoliceForces(expectedResult)
        let result = await cacheStore.object(for: cacheKey, type: [PoliceForceReference].self)

        #expect(result == expectedResult)
    }

    @Test("police force when miss returns nil")
    func policeForceWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let result = await cache.policeForce(withID: policeForceID)

        #expect(result == nil)
    }

    @Test("police force when hit returns police force")
    func policeForceWhenHitReturnsPoliceForce() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceForce.mock
        let cacheKey = PoliceForceCachingKey(id: policeForceID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.policeForce(withID: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set police force sets police force")
    func setPoliceForceSetsPoliceForce() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceForce.mock
        let cacheKey = PoliceForceCachingKey(id: policeForceID)

        await cache.setPoliceForce(expectedResult, withID: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: PoliceForce.self)

        #expect(result == expectedResult)
    }

    @Test("senior officers when miss returns nil")
    func seniorOfficersWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let result = await cache.seniorOfficers(inPoliceForce: policeForceID)

        #expect(result == nil)
    }

    @Test("senior officers when when hit returns senior officers")
    func seniorOfficersWhenWhenHitReturnsSeniorOfficers() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.seniorOfficers(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
    }

    @Test("set senior officers sets senior officers")
    func setSeniorOfficersSetsSeniorOfficers() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)

        await cache.setSeniorOfficers(expectedResult, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [PoliceOfficer].self)

        #expect(result == expectedResult)
    }

}
