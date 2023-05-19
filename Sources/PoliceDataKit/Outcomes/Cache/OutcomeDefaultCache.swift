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
