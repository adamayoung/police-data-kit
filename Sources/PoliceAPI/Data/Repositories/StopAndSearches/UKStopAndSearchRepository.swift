import Foundation
import MapKit
import os

final class UKStopAndSearchRepository: StopAndSearchRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "StopAndSearchService")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: MKCoordinateRegion

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    func stopAndSearches(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw StopAndSearchError.locationOutsideOfDataSetRegion
        }

        let dataModels: [StopAndSearchDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(
                    coordinate: coordinate, date: date
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches at \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        let stopAndSearches = dataModels.map(StopAndSearch.init)

        return stopAndSearches
    }

    func stopAndSearches(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches in area")

        let boundary = BoundaryDataModel(coordinates: coordinates)

        let dataModels: [StopAndSearchDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches in area: \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        let stopAndSearches = dataModels.map(StopAndSearch.init)

        return stopAndSearches
    }

    func stopAndSearches(atLocation streetID: Int, date: Date) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at location \(streetID, privacy: .public)")

        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

        let dataModels: [StopAndSearchDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches at location \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        let stopAndSearches = dataModels.map(StopAndSearch.init)

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async throws -> [StopAndSearch] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Stop and Searches with no location for Police Force \(policeForceID, privacy: .public)")

        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

        let dataModels: [StopAndSearchDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(
                    policeForceID: policeForceID, date: date
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches with no location for Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        let stopAndSearches = dataModels.map(StopAndSearch.init)

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches for Police Force \(policeForceID, privacy: .public)")

        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

        let dataModels: [StopAndSearchDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches for Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        let stopAndSearches = dataModels.map(StopAndSearch.init)

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

}

extension UKStopAndSearchRepository {

    private static func mapToStopAndSearchError(_ error: Error) -> StopAndSearchError {
        guard let error = error as? APIClientError else {
            return .unknown
        }

        switch error {
        case .network:
            return .network(error)

        case .notFound:
            return .notFound

        case .decode, .unknown:
            return .unknown
        }
    }

}
