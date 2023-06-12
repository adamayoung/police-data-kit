import Combine
import Foundation
import MapKit
import os

///
/// Provides an interface for obtaining outcome data from the UK Police API.
///
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12, *)
public final class OutcomeService {

    ///
    /// A single, shared outcome service object.
    ///
    /// Use this object to interface to outcome services in your application.
    ///
    public static let shared = OutcomeService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "OutcomeService")

    private let apiClient: any APIClient
    private let cache: any OutcomeCache
    private let availableDataRegion: MKCoordinateRegion

    ///
    /// Creates an outcome service object.
    ///
    /// Use this method to create different `OutcomeService` instances. If you only need one instance of
    /// `OutcomeService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.outcomeCache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some OutcomeCache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns a list of crime outcomes at a specific location.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - streetID: Street identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes for the specified street and date..
    ///
    public func streetLevelOutcomes(forStreet streetID: Int, date: Date = Date()) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes for Street \(streetID, privacy: .public)")

        if let cachedOutcomes = await cache.streetLevelOutcomes(forStreet: streetID, date: date) {
            return cachedOutcomes
        }

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes for Street \(streetID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToOutcomeError(error)
        }

        await cache.setStreetLevelOutcomes(outcomes, forStreet: streetID, date: date)

        return outcomes
    }

    ///
    /// Returns a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes in a 1 mile radius of the specified coordinate and date.
    /// 
    public func streetLevelOutcomes(at coordinate: CLLocationCoordinate2D,
                                    date: Date = Date()) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw OutcomeError.locationOutsideOfDataSetRegion
        }

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToOutcomeError(error)
        }

        return outcomes
    }

    ///
    /// Returns a publisher that wraps a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: The outcomes of crimes in a 1 mile radius of the specified coordinate and date.
    /// 
    public func streetLevelOutcomesPublisher(at coordinate: CLLocationCoordinate2D,
                                             date: Date = Date()) -> AnyPublisher<[Outcome], OutcomeError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let outcomes = try await self.streetLevelOutcomes(at: coordinate, date: date)
                    promise(.success(outcomes))
                } catch let error {
                    let outcomeError = Self.mapToOutcomeError(error)
                    promise(.failure(outcomeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns a list of crime outcomes within a custom area.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    ///   - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes within the specified area.
    ///
    public func streetLevelOutcomes(in coordinates: [CLLocationCoordinate2D],
                                    date: Date = Date()) async throws -> [Outcome] {
        Self.logger.trace("fetching street level Outcomes in area")

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching street level Outcomes in area: \(error.localizedDescription, privacy: .public)")
            throw Self.mapToOutcomeError(error)
        }

        return outcomes
    }

    ///
    /// Returns a publisher that wraps a list of crime outcomes within a custom area.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: The outcomes of crimes within the specified area.
    ///
    public func streetLevelOutcomesPublisher(in coordinates: [CLLocationCoordinate2D],
                                             date: Date = Date()) -> AnyPublisher<[Outcome], OutcomeError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let outcomes = try await self.streetLevelOutcomes(in: coordinates, date: date)
                    promise(.success(outcomes))
                } catch let error {
                    let outcomeError = Self.mapToOutcomeError(error)
                    promise(.failure(outcomeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns the case history for a crime.
    ///
    /// [https://data.police.uk/docs/method/outcomes-for-crime/](https://data.police.uk/docs/method/outcomes-for-crime/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameter crimeID: The crimeID of a crime, not the id.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The case history for the specified crime.
    ///
    public func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        Self.logger.trace("fetching Case History for crime \(crimeID, privacy: .public)")

        if let cachedCaseHistory = await cache.caseHistory(forCrime: crimeID) {
            return cachedCaseHistory
        }

        let caseHistory: CaseHistory
        do {
            caseHistory = try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Case History for crime \(crimeID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToOutcomeError(error)
        }

        await cache.setCaseHistory(caseHistory, forCrime: crimeID)

        return caseHistory
    }

}

extension OutcomeService {

    private static func mapToOutcomeError(_ error: Error) -> OutcomeError {
        if let error = error as? OutcomeError {
            return error
        }

        guard let error = error as? APIClientError else {
            return .unknown
        }

        switch error {
        case .network:
            return .network(error)

        case .notFound:
            return .notFound

        case .decode, .unknown:
            return .unknown
        }
    }

}
