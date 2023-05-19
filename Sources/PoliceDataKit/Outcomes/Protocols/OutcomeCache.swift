import Foundation

protocol OutcomeCache {

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async -> [Outcome]?

    func setStreetLevelOutcomes(_ outcomes: [Outcome], forStreet streetID: Int, date: Date) async

    func caseHistory(forCrime crimeID: String) async -> CaseHistory?

    func setCaseHistory(_ caseHistory: CaseHistory, forCrime crimeID: String) async

}
