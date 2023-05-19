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
