//
//  CrimeMockCache.swift
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

final class CrimeMockCache: CrimeCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func crimesForStreet(streetID: Int, date: Date) -> String {
            "crimes-for-street-\(streetID)-\(date)"
        }

        static func crimesWithNoLocation(
            categoryID: CrimeCategory.ID,
            policeForceID: PoliceForce.ID,
            date: Date
        ) -> String {
            "crimes-with-no-location-\(categoryID)-\(policeForceID)-\(date)"
        }

        static func crimeCategories(date: Date) -> String {
            "crime-categories-\(date)"
        }

    }

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]? {
        cacheStore[CacheKey.crimesForStreet(streetID: streetID, date: date)] as? [Crime]
    }

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async {
        cacheStore[CacheKey.crimesForStreet(streetID: streetID, date: date)] = crimes
    }

    func crimesWithNoLocation(
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async -> [Crime]? {
        let key = CacheKey.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date)
        return cacheStore[key] as? [Crime]
    }

    func setCrimesWithNoLocation(
        _ crimes: [Crime],
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        let key = CacheKey.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date)
        cacheStore[key] = crimes
    }

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]? {
        cacheStore[CacheKey.crimeCategories(date: date)] as? [CrimeCategory]
    }

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async {
        cacheStore[CacheKey.crimeCategories(date: date)] = crimeCategories
    }

}
