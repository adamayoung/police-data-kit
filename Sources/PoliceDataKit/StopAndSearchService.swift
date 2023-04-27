import CoreLocation
import Foundation

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

    private let stopAndSearchRepository: any StopAndSearchRepository

    ///
    /// Creates a stop and search service object.
    ///
    /// Use this method to create different `StopAndSearchService` instances. If you only need one instance of
    /// `StopAndSearchService`, use `shared`.
    ///
    public convenience init() {
        self.init(stopAndSearchRepository: PoliceDataKitFactory.stopAndSearchRepository())
    }

    init(stopAndSearchRepository: some StopAndSearchRepository) {
        self.stopAndSearchRepository = stopAndSearchRepository
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
                                date: Date = Date()) async throws -> [StopAndSearch]? {
        let stopAndSearches = try await stopAndSearchRepository.stopAndSearches(at: coordinate, date: date)

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
        let stopAndSearches = try await stopAndSearchRepository.stopAndSearches(in: coordinates, date: date)

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
        let stopAndSearches = try await stopAndSearchRepository.stopAndSearches(atLocation: streetID, date: date)

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
        let stopAndSearches = try await stopAndSearchRepository.stopAndSearchesWithNoLocation(
            forPoliceForce: policeForceID, date: date
        )

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
        let stopAndSearches = try await stopAndSearchRepository.stopAndSearches(forPoliceForce: policeForceID,
                                                                                date: date)

        return stopAndSearches
    }

}
