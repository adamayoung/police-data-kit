import CoreLocation
import Foundation

///
/// Provides an interface for obtaining outcome data from the UK Police Data API.
///
public final class OutcomeService {

    ///
    /// A single, shared outcome service object.
    ///
    /// Use this object to interface to outcome services in your application.
    ///
    public static let shared = OutcomeService()

    private let outcomeRepository: any OutcomeRepository

    ///
    /// Creates an outcome service object.
    ///
    /// Use this method to create different `OutcomeService` instances. If you only need one instance of
    /// `OutcomeService`, use `shared`.
    ///
    public convenience init() {
        self.init(outcomeRepository: PoliceDataKitFactory.outcomeRepository())
    }

    init(outcomeRepository: some OutcomeRepository) {
        self.outcomeRepository = outcomeRepository
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
    /// - Throws: Outcome data error `OutcomeError`.
    ///
    /// - Returns: The outcomes of crimes for the specified street and date..
    ///
    public func streetLevelOutcomes(forStreet streetID: Int, date: Date = Date()) async throws -> [Outcome] {
        let outcomes = try await outcomeRepository.streetLevelOutcomes(forStreet: streetID, date: date)

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
    /// - Throws: Outcome data error `OutcomeError`.
    ///
    /// - Returns: The outcomes of crimes in a 1 mile radius of the specified coordinate and date.
    /// 
    public func streetLevelOutcomes(at coordinate: CLLocationCoordinate2D,
                                    date: Date = Date()) async throws -> [Outcome]? {
        let outcomes = try await outcomeRepository.streetLevelOutcomes(at: coordinate, date: date)

        return outcomes
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
    ///   - Throws: Outcome data error `OutcomeError`.
    ///
    /// - Returns: The outcomes of crimes within the specified area.
    ///
    public func streetLevelOutcomes(in coordinates: [CLLocationCoordinate2D],
                                    date: Date = Date()) async throws -> [Outcome] {
        let outcomes = try await outcomeRepository.streetLevelOutcomes(in: coordinates, date: date)

        return outcomes
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
    /// - Throws: Outcome data error `OutcomeError`.
    ///
    /// - Returns: The case history for the specified crime.
    ///
    public func caseHistory(forCrime crimeID: String) async throws -> CaseHistory? {
        let caseHistory = try await outcomeRepository.caseHistory(forCrime: crimeID)

        return caseHistory
    }

}
