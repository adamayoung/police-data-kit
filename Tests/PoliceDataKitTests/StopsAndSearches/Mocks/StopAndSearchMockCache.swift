//
//  StopAndSearchMockCache.swift
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

import Foundation
@testable import PoliceDataKit

final class StopAndSearchMockCache: StopAndSearchCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func stopAndSearches(streetID: Int, date: Date) -> String {
            "stop-and-searches-location-\(streetID)-\(date)"
        }

        static func stopAndSearchesWithNoLocation(policeForceID: PoliceForce.ID, date: Date) -> String {
            "stop-and-searches-no-location-\(policeForceID)-\(date)"
        }

        static func stopAndSearches(policeForceID: PoliceForce.ID, date: Date) -> String {
            "stop-and-searches-police-force-\(policeForceID)-\(date)"
        }

    }

    func stopAndSearches(atLocation streetID: Int, date: Date) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearches(streetID: streetID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], atLocation streetID: Int, date: Date) async {
        cacheStore[CacheKey.stopAndSearches(streetID: streetID, date: date)] = stopAndSearches
    }

    func stopAndSearchesWithNoLocation(
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearchesWithNoLocation(
        _ stopAndSearches: [StopAndSearch],
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        cacheStore[CacheKey.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date)] = stopAndSearches
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearches(policeForceID: policeForceID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearches(
        _ stopAndSearches: [StopAndSearch],
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        cacheStore[CacheKey.stopAndSearches(policeForceID: policeForceID, date: date)] = stopAndSearches
    }

}
