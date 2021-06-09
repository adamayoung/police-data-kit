import Foundation

#if canImport(Combine)
import Combine
#endif

/// Stop and Search information.
///
/// - Note: The data published is provided by police forces on a monthly basis. The data submitted goes through validation to check for mandatory fields and data formats. The location coordinates of the stop are anonymised and the age of the person stopped is changed to an age group (e.g. 18-24) before publication.
public protocol StopAndSearchService {

    /// Fetches stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchAll(atCoordinate coordinate: Coordinate, date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    /// Fetches stop and searches at street-level within a custom area.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchAll(inArea coordinates: [Coordinate], date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    /// Fetches stop and searches at a particular location.
    ///
    /// - Note: [Police API | Stop and searches by location](https://data.police.uk/docs/method/stops-at-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchAll(atLocation streetID: Int, date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    /// Fetches stop and searches that could not be mapped to a location.
    ///
    /// - Note: [Police API | Stop and searches with no location](https://data.police.uk/docs/method/stops-no-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchAllWithNoLocation(forPoliceForce policeForceID: String, date: Date?,
                                completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    /// Fetches stop and searches reported by a particular force.
    ///
    /// - Note: [Police API | Stop and searches by force](https://data.police.uk/docs/method/stops-force/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of stop and searches.
    func fetchAll(forPoliceForce policeForceID: String, date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atCoordinate coordinate: Coordinate,
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>

    /// Publishes stop and searches at street-level within a custom area.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(inArea coordinates: [Coordinate],
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>

    /// Publishes stop and searches at a particular location.
    ///
    /// - Note: [Police API | Stop and searches by location](https://data.police.uk/docs/method/stops-at-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atLocation streetID: Int,
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>

    /// Publishes stop and searches that could not be mapped to a location.
    ///
    /// - Note: [Police API | Stop and searches with no location](https://data.police.uk/docs/method/stops-no-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesWithNoLocationPublisher(forPoliceForce policeForceID: String,
                                                date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>

    /// Publishes stop and searches reported by a particular force.
    ///
    /// - Note: [Police API | Stop and searches by force](https://data.police.uk/docs/method/stops-force/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of of stop and searches.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(forPoliceForce policeForceID: String,
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError>
    #endif

}

public extension StopAndSearchService {

    func fetchAll(atCoordinate coordinate: Coordinate, date: Date? = nil,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        fetchAll(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchAll(inArea coordinates: [Coordinate], date: Date? = nil,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        fetchAll(inArea: coordinates, date: date, completion: completion)
    }

    func fetchAll(atLocation streetID: Int, date: Date? = nil,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        fetchAll(atLocation: streetID, date: date, completion: completion)
    }

    func fetchAllWithNoLocation(forPoliceForce policeForceID: String, date: Date? = nil,
                                completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        fetchAllWithNoLocation(forPoliceForce: policeForceID, date: date, completion: completion)
    }

    func fetchAll(forPoliceForce policeForceID: String, date: Date? = nil,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        fetchAll(forPoliceForce: policeForceID, date: date, completion: completion)
    }

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atCoordinate coordinate: Coordinate,
                                  date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesPublisher(atCoordinate: coordinate, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(inArea coordinates: [Coordinate],
                                  date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesPublisher(inArea: coordinates, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atLocation streetID: Int,
                                  date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesPublisher(atLocation: streetID, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesWithNoLocationPublisher(forPoliceForce policeForceID: String,
                                                date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesWithNoLocationPublisher(forPoliceForce: policeForceID, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(forPoliceForce policeForceID: String,
                                  date: Date? = nil) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        stopAndSearchesPublisher(forPoliceForce: policeForceID, date: date)
    }
    #endif

}

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension StopAndSearchService {

    /// Returns stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func all(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [StopAndSearch] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(atCoordinate: coordinate, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns stop and searches at street-level within a custom area.
    ///
    /// - Note: [Police API | Stop and searches by area](https://data.police.uk/docs/method/stops-street/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func all(inArea coordinates: [Coordinate], date: Date? = nil) async throws -> [StopAndSearch] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(inArea: coordinates, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns stop and searches at a particular location.
    ///
    /// - Note: [Police API | Stop and searches by location](https://data.police.uk/docs/method/stops-at-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func all(atLocation streetID: Int, date: Date? = nil) async throws -> [StopAndSearch] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(atLocation: streetID, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns stop and searches that could not be mapped to a location.
    ///
    /// - Note: [Police API | Stop and searches with no location](https://data.police.uk/docs/method/stops-no-location/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func allWithNoLocation(forPoliceForce policeForceID: String, date: Date? = nil) async throws -> [StopAndSearch] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAllWithNoLocation(forPoliceForce: policeForceID, date: date,
                                        completion: continuation.resume(with:))
        }
    }

    /// Returns stop and searches reported by a particular force.
    ///
    /// - Note: [Police API | Stop and searches by force](https://data.police.uk/docs/method/stops-force/)
    /// - Note: The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    func all(forPoliceForce policeForceID: String, date: Date? = nil) async throws -> [StopAndSearch] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(forPoliceForce: policeForceID, date: date, completion: continuation.resume(with:))
        }
    }

}
#endif
