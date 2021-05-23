import Foundation

#if canImport(Combine)
import Combine
#endif

/// Stop and Search information.
///
/// - Note: The data published is provided by police forces on a monthly basis. The data submitted goes through validation to check for mandatory fields and data formats. The location coordinates of the stop are anonymised and the age of the person stopped is changed to an age group (e.g. 18-24) before publication.
public protocol StopAndSearchesService {

    /// Fetches stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchStopAndSearchesByArea(atCoordinate coordinate: Coordinate, date: Date?,
                                    completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesByAreaPublisher(atCoordinate coordinate: Coordinate,
                                        date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>
    #endif

}

public extension StopAndSearchesService {

    func fetchStopAndSearchesByArea(
        atCoordinate coordinate: Coordinate, date: Date? = nil,
        completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)
    {
        fetchStopAndSearchesByArea(atCoordinate: coordinate, date: date, completion: completion)
    }

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesByAreaPublisher(atCoordinate coordinate: Coordinate,
                                        date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesByAreaPublisher(atCoordinate: coordinate, date: date)
    }
    #endif

}
