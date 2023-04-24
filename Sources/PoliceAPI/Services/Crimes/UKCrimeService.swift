import Foundation
import os

final class UKCrimeService: CrimeService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "CrimeService")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: CoordinateRegion

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: CoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date) async throws -> [Crime]? {
        Self.logger.trace("fetching street level Crimes at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

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

    func streetLevelCrimes(inArea boundary: Boundary, date: Date) async throws -> [Crime]? {
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

    func crimes(forStreet streetID: Int, date: Date) async throws -> [Crime] {
        Self.logger.trace("fetching Crimes for street \(streetID, privacy: .public)")

        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        if let cachedCrimes = await cache.object(for: cacheKey, type: [Crime].self) {
            return cachedCrimes
        }

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

        await cache.set(crimes, for: cacheKey)

        return crimes
    }

    func crimes(atCoordinate coordinate: Coordinate, date: Date) async throws -> [Crime]? {
        Self.logger.trace("fetching Crimes at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

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
                              date: Date) async throws -> [Crime] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Crimes with no location for category \(categoryID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        if let cachedCrimes = await cache.object(for: cacheKey, type: [Crime].self) {
            return cachedCrimes
        }

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

        await cache.set(crimes, for: cacheKey)

        return crimes
    }

    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory] {
        Self.logger.trace("fetching Crime categories for date \(date, privacy: .public)")

        let cacheKey = CrimeCategoriesCachingKey(date: date)
        if let cachedCategories = await cache.object(for: cacheKey, type: [CrimeCategory].self) {
            return cachedCategories
        }

        let categories: [CrimeCategory]
        do {
            categories = try await apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Crime categories for date \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(categories, for: cacheKey)

        return categories
    }

}
