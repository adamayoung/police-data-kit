//
//  OutcomeDefaultCache.swift
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

final class OutcomeDefaultCache: OutcomeCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async -> [Outcome]? {
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        let cachedOutcomes = await cacheStore.object(for: cacheKey, type: [Outcome].self)

        return cachedOutcomes
    }

    func setStreetLevelOutcomes(_ outcomes: [Outcome], forStreet streetID: Int, date: Date) async {
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)

        await cacheStore.set(outcomes, for: cacheKey)
    }

    func caseHistory(forCrime crimeID: String) async -> CaseHistory? {
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        let cachedCaseHistory = await cacheStore.object(for: cacheKey, type: CaseHistory.self)

        return cachedCaseHistory
    }

    func setCaseHistory(_ caseHistory: CaseHistory, forCrime crimeID: String) async {
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)

        await cacheStore.set(caseHistory, for: cacheKey)
    }

}
