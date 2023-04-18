import Foundation

/// Get information about a Crimes.
public protocol CrimeService {

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
    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime]

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
    func streetLevelCrimes(inArea coordinates: [Coordinate], date: Date?) async throws -> [Crime]

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
    func crimes(forStreet streetID: Int, date: Date?) async throws -> [Crime]

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
    func crimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime]

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
    func crimesWithNoLocation(forCategory categoryID: String, inPoliceForce policeForceID: String,
                              date: Date?) async throws -> [Crime]

    /// Fetches a list of valid crime categories for a given data set date.
    ///
    /// - Note: [Police API | Crime categories](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameters:
    ///     - date: Date to fetch crime categories for. Fetches for the month.
    ///     - completion: Completion handler.
    ///     - result: A list of crime categories
    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory]

}

extension CrimeService {

    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [Crime] {
        try await streetLevelCrimes(atCoordinate: coordinate, date: date)
    }

    func streetLevelCrimes(inArea coordinates: [Coordinate], date: Date? = nil) async throws -> [Crime] {
        try await streetLevelCrimes(inArea: coordinates, date: date)
    }

    func crimes(forStreet streetID: Int, date: Date? = nil) async throws -> [Crime] {
        try await crimes(forStreet: streetID, date: date)
    }

    func crimes(atCoordinate coordinate: Coordinate, date: Date? = nil) async throws -> [Crime] {
        try await crimes(atCoordinate: coordinate, date: date)
    }

    func crimesWithNoLocation(forCategory categoryID: String = CrimeCategory.defaultID,
                              inPoliceForce policeForceID: String, date: Date? = nil) async throws -> [Crime] {
        try await crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)
    }

    func crimeCategories(forDate date: Date = .init()) async throws -> [CrimeCategory] {
        try await crimeCategories(forDate: date)
    }

}
