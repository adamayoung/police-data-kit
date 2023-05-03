import Foundation
import MapKit
import os

///
/// Provides an interface for obtaining stop and search data from the UK Police Data API.
///
/// The data published is provided by police forces on a monthly basis. The data submitted goes through
/// validation to check for mandatory fields and data formats. The location coordinates of the stop are anonymised
/// and the age of the person stopped is changed to an age group (e.g. 18-24) before publication.
///
public final class StopAndSearchService {

    ///
    /// A single, shared stop and search service object.
    ///
    /// Use this object to interface to stop and search services in your application.
    ///
    public static let shared = StopAndSearchService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "StopAndSearchService")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: MKCoordinateRegion

    ///
    /// Creates a stop and search service object.
    ///
    /// Use this method to create different `StopAndSearchService` instances. If you only need one instance of
    /// `StopAndSearchService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.cache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches
    /// occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation)
    /// for more information about location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error `StopAndSearchError`.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(at coordinate: CLLocationCoordinate2D,
                                date: Date = Date()) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw StopAndSearchError.locationOutsideOfDataSetRegion
        }

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
            throw Self.mapToStopAndSearchError(error)
        }

        return stopAndSearches
    }

    ///
    /// Returns stop and searches at street-level within a custom area.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error `StopAndSearchError`.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(in coordinates: [CLLocationCoordinate2D],
                                date: Date = Date()) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches in area")

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches in area: \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        return stopAndSearches
    }

    ///
    /// Returns stop and searches at a particular location.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-at-location/](https://data.police.uk/docs/method/stops-at-location/)
    ///
    /// - Parameters:
    ///   - streetID: A street ID.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error `StopAndSearchError`.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(atLocation streetID: Int, date: Date = Date()) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches at location \(streetID, privacy: .public)")

        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches at location \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

    ///
    /// Returns stop and searches that could not be mapped to a location.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-no-location/](https://data.police.uk/docs/method/stops-no-location/)
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error `StopAndSearchError`.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                              date: Date = Date()) async throws -> [StopAndSearch] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Stop and Searches with no location for Police Force \(policeForceID, privacy: .public)")

        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

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
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

    ///
    /// Returns stop and searches reported by a particular force.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-force/](https://data.police.uk/docs/method/stops-force/)
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error `StopAndSearchError`.
    ///
    /// - Returns: A list of stop and searches.
    /// 
    public func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID,
                                date: Date = Date()) async throws -> [StopAndSearch] {
        Self.logger.trace("fetching Stop and Searches for Police Force \(policeForceID, privacy: .public)")

        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        if let cachedStopAndSearches = await cache.object(for: cacheKey, type: [StopAndSearch].self) {
            return cachedStopAndSearches
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Stop and Searches for Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.set(stopAndSearches, for: cacheKey)

        return stopAndSearches
    }

}

extension StopAndSearchService {

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
