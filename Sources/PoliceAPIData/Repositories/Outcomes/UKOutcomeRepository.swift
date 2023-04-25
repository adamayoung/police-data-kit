import Foundation
import os
import PoliceAPIDomain

public final class UKOutcomeRepository: OutcomeRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "UKOutcomeRepository")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: CoordinateRegionDataModel

    public convenience init(apiClient: some APIClient, cache: some Cache) {
        self.init(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: CoordinateRegionDataModel) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    public func streetLevelOutcomes(forStreet streetID: Int, date: Date) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes for Street \(streetID, privacy: .public)")

        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        if let cachedOutcomes = await cache.object(for: cacheKey, type: [Outcome].self) {
            return cachedOutcomes
        }

        let dataModels: [OutcomeDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes for Street \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let outcomes = dataModels.map(Outcome.init)

        await cache.set(outcomes, for: cacheKey)

        return outcomes
    }

    public func streetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date) async throws -> [Outcome]? {
        Self.logger.trace("fetching street level Outcomes at coordinate \(coordinate, privacy: .public)")

        let coordinate = CoordinateDataModel(coordinate: coordinate)

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

        let dataModels: [OutcomeDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let outcomes = dataModels.map(Outcome.init)

        return outcomes
    }

    public func streetLevelOutcomes(inArea boundary: Boundary, date: Date) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes in area")

        let boundary = BoundaryDataModel(boundary: boundary)

        let dataModels: [OutcomeDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(boundary: boundary, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes in area: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let outcomes = dataModels.map(Outcome.init)

        return outcomes
    }

    public func caseHistory(forCrime crimeID: String) async throws -> CaseHistory? {
        Self.logger.trace("fetching Case History for crime \(crimeID, privacy: .public)")

        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        if let cachedCaseHistory = await cache.object(for: cacheKey, type: CaseHistory.self) {
            return cachedCaseHistory
        }

        let dataModel: CaseHistoryDataModel
        do {
            dataModel = try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
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

        let caseHistory = CaseHistory(dataModel: dataModel)

        await cache.set(caseHistory, for: cacheKey)

        return caseHistory
    }

}
