import Foundation

/// Information about Stop and Searches.
///
/// - Note: The data published is provided by police forces on a monthly basis. The data submitted goes through validation to check for mandatory fields and data formats. The location coordinates of the stop are anonymised and the age of the person stopped is changed to an age group (e.g. 18-24) before publication.
protocol StopAndSearchRepository {

    /// Returns stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func stopAndSearches(atCoordinate coordinate: CoordinateDataModel, date: Date) async throws -> [StopAndSearchDataModel]?

    /// Returns stop and searches at street-level within a custom area.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func stopAndSearches(inArea boundary: BoundaryDataModel, date: Date) async throws -> [StopAndSearchDataModel]

    /// Returns stop and searches at a particular location.
    ///
    /// - Note: [Police API | Stop and searches by location](https://data.police.uk/docs/method/stops-at-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///   - streetID: A street ID.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func stopAndSearches(atLocation streetID: Int, date: Date) async throws -> [StopAndSearchDataModel]

    /// Returns stop and searches that could not be mapped to a location.
    ///
    /// - Note: [Police API | Stop and searches with no location](https://data.police.uk/docs/method/stops-no-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForceDataModel.ID,
                                       date: Date) async throws -> [StopAndSearchDataModel]

    /// Returns stop and searches reported by a particular force.
    ///
    /// - Note: [Police API | Stop and searches by force](https://data.police.uk/docs/method/stops-force/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func stopAndSearches(forPoliceForce policeForceID: PoliceForceDataModel.ID, date: Date) async throws -> [StopAndSearchDataModel]

}

extension StopAndSearchRepository {

    func stopAndSearches(atCoordinate coordinate: CoordinateDataModel) async throws -> [StopAndSearchDataModel]? {
        try await stopAndSearches(atCoordinate: coordinate, date: Date())
    }

    func stopAndSearches(inArea boundary: BoundaryDataModel) async throws -> [StopAndSearchDataModel] {
        try await stopAndSearches(inArea: boundary, date: Date())
    }

    func stopAndSearches(atLocation streetID: Int) async throws -> [StopAndSearchDataModel] {
        try await stopAndSearches(atLocation: streetID, date: Date())
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [StopAndSearchDataModel] {
        try await stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: Date())
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [StopAndSearchDataModel] {
        try await stopAndSearches(forPoliceForce: policeForceID, date: Date())
    }

}

protocol StopAndSearchRepositoryProviding {

    var stopAndSearchRepository: StopAndSearchRepository { get}

}