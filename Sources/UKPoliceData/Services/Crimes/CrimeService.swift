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

    /// Fetches a list of crimes within a custom area..
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crimes.
    func fetchStreetLevelCrimes(inArea coordinates: [Coordinate], date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crime outcomes.
    func fetchStreetLevelOutcomes(forStreet streetID: Int, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void)

    /// Fetches a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crime outcomes.
    func fetchStreetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void)

    /// Fetches a list of crime outcomes within a custom area.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crime outcomes.
    func fetchStreetLevelOutcomes(inArea coordinates: [Coordinate], date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void)

    /// Fetches just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimesAtLocation(forStreet streetID: Int, date: Date?,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the cooridnate and
    /// returns the crimes which occurred there.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimesAtLocation(atCoordinate coordinate: Coordinate, date: Date?,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)

    /// Fetches a list of crimes that could not be mapped to a location.
    ///
    /// - Note: [Police API | Crimes with no location](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///     - catgeoryID: The category of the crimes. All crimes with be shown by default.
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of crimes.
    func fetchCrimesWithNoLocation(forCategory categoryID: String, inPoliceForce policeForceID: String, date: Date?,
                                   completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void)


    /// Fetches the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    ///
    /// - Parameters:
    ///     - crimeID: The crimeID of a crime, not the id.
    ///     - completion: Completion handler.
    ///     - result: The case history for a crime.
    func fetchCaseHistory(forCrime crimeID: String,
                          completion: @escaping (_ result: Result<CaseHistory, PoliceDataError>) -> Void)

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
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of crimes within a custom area..
    ///
    /// - Note: [Police API | Street-level crimes](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(inArea coordinates: [Coordinate],
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crime outcomes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(forStreet streetID: Int, date: Date?) -> AnyPublisher<[Outcome], PoliceDataError>

    /// Publishes a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crime outcomes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(atCoordinate coordinate: Coordinate,
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError>

    /// Publishes a list of crime outcomes within a custom area.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crime outcomes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(inArea coordinates: [Coordinate],
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError>

    /// Publishes just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(forStreet streetID: Int, date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the cooridnate and
    /// returns the crimes which occurred there.
    ///
    /// - Note: [Police API | Crimes at a location](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(atCoordinate coordinate: Coordinate,
                                   date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes a list of crimes that could not be mapped to a location.
    ///
    /// - Note: [Police API | Crimes with no location](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///     - catgeoryID: The category of the crimes. All crimes with be shown by default.
    ///     - policeForceID: Police Force identifier.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of crimes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesWithNoLocationPublisher(forCategory categoryID: String, inPoliceForce policeForceID: String,
                                       date: Date?) -> AnyPublisher<[Crime], PoliceDataError>

    /// Publishes the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    ///
    /// - Parameters:
    ///     - crimeID: The crimeID of a crime, not the id.
    ///
    /// - Returns: A publisher with the case history for a crime.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func caseHistoryPublisher(forCrime crimeID: String) -> AnyPublisher<CaseHistory, PoliceDataError>

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

public extension CrimeService {

    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchStreetLevelCrimes(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchStreetLevelCrimes(inArea coordinates: [Coordinate], date: Date? = nil,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchStreetLevelCrimes(inArea: coordinates, date: date, completion: completion)
    }

    func fetchStreetLevelOutcomes(forStreet streetID: Int, date: Date? = nil,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        fetchStreetLevelOutcomes(forStreet: streetID, date: date, completion: completion)
    }

    func fetchStreetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date? = nil,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        fetchStreetLevelOutcomes(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchStreetLevelOutcomes(inArea coordinates: [Coordinate], date: Date? = nil,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        fetchStreetLevelOutcomes(inArea: coordinates, date: date, completion: completion)
    }

    func fetchCrimesAtLocation(atCoordinate coordinate: Coordinate, date: Date? = nil,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimesAtLocation(atCoordinate: coordinate, date: date, completion: completion)
    }

    func fetchCrimesAtLocation(forStreet streetID: Int, date: Date? = nil,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimesAtLocation(forStreet: streetID, date: date, completion: completion)
    }

    func fetchCrimesWithNoLocation(forCategory categoryID: String = CrimeCategory.defaultID,
                                   inPoliceForce policeForceID: String, date: Date? = nil,
                                   completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        fetchCrimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date,
                                  completion: completion)
    }

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        streetLevelCrimesPublisher(atCoordinate: coordinate, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(inArea coordinates: [Coordinate],
                                    date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        streetLevelCrimesPublisher(inArea: coordinates, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(forStreet streetID: Int,
                                      date: Date? = nil) -> AnyPublisher<[Outcome], PoliceDataError> {
        streetLevelOutcomesPublisher(forStreet: streetID, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(atCoordinate coordinate: Coordinate,
                                      date: Date? = nil) -> AnyPublisher<[Outcome], PoliceDataError> {
        streetLevelOutcomesPublisher(atCoordinate: coordinate, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(inArea coordinates: [Coordinate],
                                      date: Date? = nil) -> AnyPublisher<[Outcome], PoliceDataError> {
        streetLevelOutcomesPublisher(inArea: coordinates, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(forStreet streetID: Int,
                                   date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesAtLocationPublisher(forStreet: streetID, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(atCoordinate coordinate: Coordinate,
                                   date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesAtLocationPublisher(atCoordinate: coordinate, date: date)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesWithNoLocationPublisher(forCategory categoryID: String = CrimeCategory.defaultID,
                                       inPoliceForce policeForceID: String,
                                       date: Date? = nil) -> AnyPublisher<[Crime], PoliceDataError> {
        crimesWithNoLocationPublisher(forCategory: categoryID, inPoliceForce: policeForceID, date: date)
    }
    #endif

}
