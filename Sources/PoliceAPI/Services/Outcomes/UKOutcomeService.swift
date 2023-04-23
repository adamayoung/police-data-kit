import Foundation
import os

final class UKOutcomeService: OutcomeService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "OutcomeService")

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date?) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes for Street \(streetID, privacy: .public)")

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes for Street \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return outcomes
    }

    func streetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes at coordinate \(coordinate, privacy: .public)")

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return outcomes
    }

    func streetLevelOutcomes(inArea boundary: Boundary, date: Date?) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes in area")

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(boundary: boundary, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes in area: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return outcomes
    }

    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        Self.logger.trace("fetching Case History for crime \(crimeID, privacy: .public)")

        let caseHistory: CaseHistory
        do {
            caseHistory = try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Case History for crime \(crimeID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return caseHistory
    }

}
