import Foundation
import os

final class UKStopAndSearchService: StopAndSearchService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "StopAndSearchService")

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func stopAndSearches(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at \(coordinate, privacy: .public)")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(
                    coordinate: coordinate, date: date
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches at \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return stopAndSearches
    }

    func stopAndSearches(inArea boundary: Boundary, date: Date?) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches in area")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches in area: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return stopAndSearches
    }

    func stopAndSearches(atLocation streetID: Int, date: Date?) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at location \(streetID, privacy: .public)")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches at location \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return stopAndSearches
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: String,
                                       date: Date?) async throws -> [StopAndSearch] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Stop and Searches with no location for Police Force \(policeForceID, privacy: .public)")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(
                    policeForceID: policeForceID, date: date
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches with no location for Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return stopAndSearches
    }

    func stopAndSearches(forPoliceForce policeForceID: String, date: Date?) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches for Police Force \(policeForceID, privacy: .public)")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches for Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return stopAndSearches
    }

}
