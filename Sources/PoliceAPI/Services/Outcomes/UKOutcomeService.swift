import Foundation
import os

final class UKOutcomeService: OutcomeService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "OutcomeService")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: CoordinateRegion

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: CoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes for Street \(streetID, privacy: .public)")

        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        if let cachedOutcomes = await cache.object(for: cacheKey, type: [Outcome].self) {
            return cachedOutcomes
        }

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

        await cache.set(outcomes, for: cacheKey)

        return outcomes
    }

    func streetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date) async throws -> [Outcome]? {
        Self.logger.trace("fetching street level Outcomes at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

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

    func streetLevelOutcomes(inArea boundary: Boundary, date: Date) async throws -> [Outcome] {
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

    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory? {
        Self.logger.trace("fetching Case History for crime \(crimeID, privacy: .public)")

        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        if let cachedCaseHistory = await cache.object(for: cacheKey, type: CaseHistory.self) {
            return cachedCaseHistory
        }

        let caseHistory: CaseHistory
        do {
            caseHistory = try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil
            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Case History for crime \(crimeID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(caseHistory, for: cacheKey)

        return caseHistory
    }

}
