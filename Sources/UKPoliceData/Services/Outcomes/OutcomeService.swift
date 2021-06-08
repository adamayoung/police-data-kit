import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about a Crime's Outcome.
public protocol OutcomeService {

    /// Fetches a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
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
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
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
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///     - completion: Completion handler.
    ///     - result: A list of street level crime outcomes.
    func fetchStreetLevelOutcomes(inArea coordinates: [Coordinate], date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void)

    /// Fetches the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - crimeID: The crimeID of a crime, not the id.
    ///     - completion: Completion handler.
    ///     - result: The case history for a crime.
    func fetchCaseHistory(forCrime crimeID: String,
                          completion: @escaping (_ result: Result<CaseHistory, PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
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
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
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
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A publisher with a list of street level crime outcomes.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(inArea coordinates: [Coordinate],
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError>

    /// Publishes the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - crimeID: The crimeID of a crime, not the id.
    ///
    /// - Returns: A publisher with the case history for a crime.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func caseHistoryPublisher(forCrime crimeID: String) -> AnyPublisher<CaseHistory, PoliceDataError>
    #endif

}

public extension OutcomeService {

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

    #if canImport(Combine)
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
    #endif

}

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension OutcomeService {

    /// Returns a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - streetID: A street ID.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(forStreet streetID: Int, date: Date? = nil) async throws -> [Outcome] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchStreetLevelOutcomes(forStreet: streetID, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [Outcome] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchStreetLevelOutcomes(atCoordinate: coordinate, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns a list of crime outcomes within a custom area.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - coordinates: Coordinates which define the boundary of the custom area.
    ///     - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(inArea coordinates: [Coordinate], date: Date? = nil) async throws -> [Outcome] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchStreetLevelOutcomes(inArea: coordinates, date: date, completion: continuation.resume(with:))
        }
    }

    /// Returns the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///     - crimeID: The crimeID of a crime, not the id.
    ///
    /// - Returns: The case history for a crime.
    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchCaseHistory(forCrime: crimeID, completion: continuation.resume(with:))
        }
    }

}
#endif
