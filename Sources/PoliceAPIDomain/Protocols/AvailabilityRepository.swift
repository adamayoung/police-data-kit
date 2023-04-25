import Foundation

/// Get information about availability of data.
public protocol AvailabilityRepository {

    /// Returns a list of available data sets.
    ///
    /// - Note: [Police API | Availability](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Returns: A list of available data sets.
    func availableDataSets() async throws -> [DataSet]

}

public protocol AvailabilityRepositoryProviding {

    var availabilityRepository: AvailabilityRepository { get }

}
