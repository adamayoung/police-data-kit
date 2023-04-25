import Foundation

/// Get information about a Crime's Outcome.
protocol OutcomeRepository {

    /// Returns a list of crime outcomes at a specific location.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - streetID: A street ID.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async throws -> [OutcomeDataModel]

    /// Returns a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(atCoordinate coordinate: CoordinateDataModel, date: Date) async throws -> [OutcomeDataModel]?

    /// Returns a list of crime outcomes within a custom area.
    ///
    /// - Note: [Police API | Street-level outcomes](https://data.police.uk/docs/method/outcomes-at-location/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of street level crime outcomes.
    func streetLevelOutcomes(inArea boundary: BoundaryDataModel, date: Date) async throws -> [OutcomeDataModel]

    /// Returns the case history for a crime.
    ///
    /// - Note: [Police API | Outcomes for a specific crime](https://data.police.uk/docs/method/outcomes-for-crime/)
    /// - Note: Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - crimeID: The crimeID of a crime, not the id.
    ///
    /// - Returns: The case history for a crime.
    func caseHistory(forCrime crimeID: String) async throws -> CaseHistoryDataModel?

}

extension OutcomeRepository {

    func streetLevelOutcomes(forStreet streetID: Int) async throws -> [OutcomeDataModel] {
        try await streetLevelOutcomes(forStreet: streetID, date: Date())
    }

    func streetLevelOutcomes(atCoordinate coordinate: CoordinateDataModel) async throws -> [OutcomeDataModel]? {
        try await streetLevelOutcomes(atCoordinate: coordinate, date: Date())
    }

    func streetLevelOutcomes(inArea boundary: BoundaryDataModel) async throws -> [OutcomeDataModel] {
        try await streetLevelOutcomes(inArea: boundary, date: Date())
    }

}

protocol OutcomeRepositoryProviding {

    var outcomeRepository: OutcomeRepository { get}

}
