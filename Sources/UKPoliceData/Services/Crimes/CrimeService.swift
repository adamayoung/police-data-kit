import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about a Crimes.
public protocol CrimeService {

    /// Fetches a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crimes.
    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of crimes within a custom area.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crimes.
    func fetchStreetLevelCrimes(inArea coordinates: [Coordinate], date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimes(forStreet streetID: Int, date: Date?,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the coordinate and
    /// returns the crimes which occurred there.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimes(atCoordinate coordinate: Coordinate, date: Date?,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of crimes that could not be mapped to a location.
    ///
    /// - Note: [Police API | Crimes with no location](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///     - categoryID: The category of the crimes. All crimes with be shown by default.
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimesWithNoLocation(forCategory categoryID: String, inPoliceForce policeForceID: String, date: Date?,
                                   completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime categories for. Fetches for the month.
    ///     - completion: Completion handler.
    ///     - result: A list of crime categories
    func fetchCrimeCategories(forDate: Date,
                              completion: @escaping (_ result: Result<[CrimeCategory], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of crimes within a custom area..
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(inArea coordinates: [Coordinate],
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesPublisher(forStreet streetID: Int, date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the coordinate and
    /// returns the crimes which occurred there.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesPublisher(atCoordinate coordinate: Coordinate, date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of crimes that could not be mapped to a location.
    ///
    /// - Note: [Police API | Crimes with no location](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///     - categoryID: The category of the crimes. All crimes with be shown by default.
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesWithNoLocationPublisher(forCategory categoryID: String, inPoliceForce policeForceID: String,
                                       date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime categories for. Fetches for the month.
    ///
    /// - Returns: A publisher with a list of crime categories.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimeCategoriesPublisher(forDate date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError>
    #endif

}

public extension CrimeService {

    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchStreetLevelCrimes(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchStreetLevelCrimes(inArea coordinates: [Coordinate], date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchStreetLevelCrimes(inArea: coordinates, date: date, completion: completion)
    }

    func fetchCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimes(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchCrimes(forStreet streetID: Int, date: Date? = nil,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimes(forStreet: streetID, date: date, completion: completion)
    }

    func fetchCrimesWithNoLocation(forCategory categoryID: String = CrimeCategory.defaultID,
                                   inPoliceForce policeForceID: String, date: Date? = nil,
                                   completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date,
                                  completion: completion)
    }

    func fetchCrimeCategories(forDate date: Date = .init(),
                              completion: @escaping (_ result: Result<[CrimeCategory], PoliceDataError>) -> Void) {
        fetchCrimeCategories(forDate: date, completion: completion)
    }

}

#if canImport(Combine)
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension CrimeService {

    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        streetLevelCrimesPublisher(atCoordinate: coordinate, date: date)
    }

    func streetLevelCrimesPublisher(inArea coordinates: [Coordinate],
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        streetLevelCrimesPublisher(inArea: coordinates, date: date)
    }

    func crimesAtLocationPublisher(forStreet streetID: Int,
                                   date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesPublisher(forStreet: streetID, date: date)
    }

    func crimesAtLocationPublisher(atCoordinate coordinate: Coordinate,
                                   date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesPublisher(atCoordinate: coordinate, date: date)
    }

    func crimesWithNoLocationPublisher(forCategory categoryID: String = CrimeCategory.defaultID,
                                       inPoliceForce policeForceID: String,
                                       date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesWithNoLocationPublisher(forCategory: categoryID, inPoliceForce: policeForceID, date: date)
    }

}
#endif

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension CrimeService {

    /// Returns a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crimes.
    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [Crime] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchStreetLevelCrimes(atCoordinate: coordinate, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns a list of crimes within a custom area.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    /// - Note: The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about location anonymisation.
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crimes.
    func streetLevelCrimes(inArea coordinates: [Coordinate], date: Date? = nil) async throws -> [Crime] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchStreetLevelCrimes(inArea: coordinates, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of crimes.
    func crimes(forStreet streetID: Int, date: Date? = nil) async throws -> [Crime] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchCrimes(forStreet: streetID, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the coordinate and
    /// the crimes which occurred there.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    /// - Note: Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of crimes.
    @available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func crimes(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [Crime] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchCrimes(atCoordinate: coordinate, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns a list of crimes that could not be mapped to a location.
    ///
    /// - Note: [Police API | Crimes with no location](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///     - categoryID: The category of the crimes. All crimes with be shown by default.
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of crimes.
    func crimesWithNoLocation(forCategory categoryID: String = CrimeCategory.defaultID,
                              inPoliceForce policeForceID: String, date: Date? = nil) async throws -> [Crime] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchCrimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date,
                                           completion: continuation.resume(with:))
        }
    }

    /// Fetches a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime categories for. Fetches for the month.
    ///     - completion: Completion handler.
    ///     - result: A list of crime categories
    func crimeCategories(forDate date: Date = .init()) async throws -> [CrimeCategory] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchCrimeCategories(forDate: date, completion: continuation.resume(with:))
        }
    }

}
#endif
