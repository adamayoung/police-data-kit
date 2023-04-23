import Foundation
import os

final class UKCrimeService: CrimeService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "CrimeService")

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime] {
        Self.logger.trace("fetching street level Crimes at coordinate \(coordinate, privacy: .public)")

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Crimes at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return crimes
    }

    func streetLevelCrimes(inArea boundary: Boundary, date: Date?) async throws -> [Crime] {
        Self.logger.trace("fetching street level Crimes in area")

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Crimes in area: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return crimes
    }

    func crimes(forStreet streetID: Int, date: Date?) async throws -> [Crime] {
        Self.logger.trace("fetching Crimes for street \(streetID, privacy: .public)")

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Crimes for street \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return crimes
    }

    func crimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime] {
        Self.logger.trace("fetching Crimes at coordinate \(coordinate, privacy: .public)")

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Crimes at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return crimes
    }

    func crimesWithNoLocation(forCategory categoryID: CrimeCategory.ID, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date?) async throws -> [Crime] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Crimes with no location for category \(categoryID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesWithNoLocation(
                    categoryID: categoryID, policeForceID: policeForceID, date: date
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Crimes with no location for category \(categoryID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return crimes
    }

    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory] {
        Self.logger.trace("fetching Crime categories for date \(date, privacy: .public)")

        let categories: [CrimeCategory]
        do {
            categories = try await apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Crime categories for date \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return categories
    }

}
