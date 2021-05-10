import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about a Crimes.
public protocol CrimeService {

    /// Fetches a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crimes.
    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime catergories for. Fetches for the month.
    ///     - completion: Completion handler.
    ///     - result: A list of crime categories
    func fetchCategories(date: Date,
                         completion: @escaping (_ result: Result<[CrimeCategory], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crimes.
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime catergories for. Fetches for the month.
    ///
    /// - Returns: A publisher with a list of crime categories.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func categoriesPublisher(date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError>
    #endif

}

extension CrimeService {

    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchStreetLevelCrimes(atCoordinate: coordinate, date: date, completion: completion)
    }

    /// Fetches a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - latitude: A latitude.
    ///     - longitude: A longitude.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crimes.
    func fetchStreetLevelCrimes(atLatitude latitude: Double, longitude: Double, date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        fetchStreetLevelCrimes(atCoordinate: coordinate, date: date, completion: completion)
    }

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        streetLevelCrimesPublisher(atCoordinate: coordinate, date: date)
    }

    /// Publishes a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - latitude: A latitude.
    ///     - longitude: A longitude.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atLatitude latitude: Double, longitude: Double,
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        return streetLevelCrimesPublisher(atCoordinate: coordinate, date: date)
    }
    #endif

}
