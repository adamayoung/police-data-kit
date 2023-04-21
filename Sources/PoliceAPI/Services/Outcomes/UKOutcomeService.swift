import Foundation

final class UKOutcomeService: OutcomeService {

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date?) async throws -> [Outcome] {
        try await apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date))
    }

    func streetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Outcome] {
        try await apiClient.get(
            endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date)
        )
    }

    func streetLevelOutcomes(inArea boundary: Boundary, date: Date?) async throws -> [Outcome] {
        try await apiClient.get(
            endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(boundary: boundary, date: date)
        )
    }

    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
    }

}
