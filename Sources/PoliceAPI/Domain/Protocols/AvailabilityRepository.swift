import Foundation

/// Get information about availability of data.
protocol AvailabilityRepository {

    /// Returns a list of available data sets.
    ///
    /// - Note: [Police API | Availability](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Returns: A list of available data sets.
    func availableDataSets() async throws -> [DataSetDataModel]

    /// Returns the region of data availability - UK.
    ///
    /// - Returns: Region defining the area which data is available for
    func availableDataRegion() -> CoordinateRegionDataModel

}

protocol AvailabilityRepositoryProviding {

    var availabilityRepository: AvailabilityRepository { get}

}
