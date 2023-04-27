import CoreLocation
import Foundation

///
/// Provides an interface for obtaining crime data from the UK Police Data API.
///
public final class CrimeService {

    ///
    /// A single, shared crime service object.
    ///
    /// Use this object to interface to crime services in your application.
    ///
    public static let shared = CrimeService()

    private let crimeRepository: any CrimeRepository

    ///
    /// Creates a crime service object.
    ///
    /// Use this method to create different `CrimeService` instances. If you only need one instance of
    /// `CrimeService`, use `shared`.
    ///
    public convenience init() {
        self.init(crimeRepository: PoliceAPIFactory.crimeRepository())
    }

    init(crimeRepository: some CrimeRepository) {
        self.crimeRepository = crimeRepository
    }

    /// 
    /// Returns a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not
    /// the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    ///
    /// - Returns: The street level crimes in a 1 mile radius of the specifed coordinate and date.
    ///
    func streetLevelCrimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime] {
        let crimes = try await crimeRepository.streetLevelCrimes(at: coordinate, date: date)

        return crimes
    }

    ///
    /// Returns a list of crimes within a custom area.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    ///
    /// - Returns: The street level crimes with the specified area and month..
    ///
    func streetLevelCrimes(in coordinates: [CLLocationCoordinate2D], date: Date = Date()) async throws -> [Crime]? {
        let crimes = try await crimeRepository.streetLevelCrimes(in: coordinates, date: date)

        return crimes
    }

    ///
    /// Returns just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crimes-at-location/](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///   - streetID: The street identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    ///
    /// - Returns: The crimes at the specified street and date.
    /// 
    func crimes(forStreet streetID: Int, date: Date = Date()) async throws -> [Crime] {
        let crimes = try await crimeRepository.crimes(forStreet: streetID, date: date)

        return crimes
    }

    ///
    /// Returns just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the coordinate and
    /// the crimes which occurred there.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crimes-at-location/](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    ///
    /// - Returns: The crimes for the street nearest to the specified coordinate and date.
    ///
    func crimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime]? {
        let crimes = try await crimeRepository.crimes(at: coordinate, date: date)

        return crimes
    }

    ///
    /// Returns a list of crimes that could not be mapped to a location.
    ///
    /// [https://data.police.uk/docs/method/crimes-no-location/](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///   - category: The category of the crimes. All crimes with be shown by default.
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    ///
    /// - Returns: The crimes not mapped to a location.
    ///
    func crimesWithNoLocation(
        forCategory category: CrimeCategory = CrimeCategory.default,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date = Date()
    ) async throws -> [Crime] {
        let crimes = try await crimeRepository.crimesWithNoLocation(forCategory: category, inPoliceForce: policeForceID,
                                                                    date: date)

        return crimes
    }

    ///
    /// Returns a list of valid crime categories for a given data set date.
    ///
    /// [https://data.police.uk/docs/method/crime-categories/](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameter date: Month to fetch crime categories for. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error `CrimeError`.
    /// 
    /// - Returns: The crime categories for the specified month.
    ///
    func crimeCategories(forDate date: Date = Date()) async throws -> [CrimeCategory] {
        let categories = try await crimeRepository.crimeCategories(forDate: date)

        return categories
    }

}
