//
//  OutcomeMockCache.swift
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

final class OutcomeMockCache: OutcomeCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func streetLevelOutcomes(streetID: Int, date: Date) -> String {
            "street-level-outcomes-\(streetID)-\(date)"
        }

        static func caseHistory(crimeID: String) -> String {
            "case-history-\(crimeID)"
        }

    }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async -> [Outcome]? {
        cacheStore[CacheKey.streetLevelOutcomes(streetID: streetID, date: date)] as? [Outcome]
    }

    func setStreetLevelOutcomes(_ outcomes: [Outcome], forStreet streetID: Int, date: Date) async {
        cacheStore[CacheKey.streetLevelOutcomes(streetID: streetID, date: date)] = outcomes
    }

    func caseHistory(forCrime crimeID: String) async -> CaseHistory? {
        cacheStore[CacheKey.caseHistory(crimeID: crimeID)] as? CaseHistory
    }

    func setCaseHistory(_ caseHistory: CaseHistory, forCrime crimeID: String) async {
        cacheStore[CacheKey.caseHistory(crimeID: crimeID)] = caseHistory
    }

}
