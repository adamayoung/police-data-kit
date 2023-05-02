import CoreLocation
import Foundation
import os

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

    private static let logger = Logger(subsystem: Logger.domainSubsystem, category: "CrimeService")

    private let crimeRepository: any CrimeRepository

    ///
    /// Creates a crime service object.
    ///
    /// Use this method to create different `CrimeService` instances. If you only need one instance of
    /// `CrimeService`, use `shared`.
    ///
    public convenience init() {
        self.init(crimeRepository: PoliceDataKitFactory.crimeRepository())
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
    public func streetLevelCrimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime] {
        Self.logger.info("Fetching street level crimes at \(coordinate, privacy: .public) on \(date, privacy: .public)...")

        let crimes: [Crime]
        do {
            crimes = try await crimeRepository.streetLevelCrimes(at: coordinate, date: date)
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("Failed fetched street level crimes at \(coordinate, privacy: .public) on \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        // swiftlint:disable:next line_length
        Self.logger.info("Fetched \(crimes.count, privacy: .public) street level crimes at \(coordinate, privacy: .public) on \(date, privacy: .public)")

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
    public func streetLevelCrimes(in coordinates: [CLLocationCoordinate2D],
                                  date: Date = Date()) async throws -> [Crime] {
        Self.logger.info("Fetching street level crimes in \(coordinates, privacy: .public) on \(date, privacy: .public)...")

        let crimes: [Crime]
        do {
            crimes = try await crimeRepository.streetLevelCrimes(in: coordinates, date: date)
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("Failed fetched street level crimes in \(coordinates, privacy: .public) on \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        // swiftlint:disable:next line_length
        Self.logger.info("Fetched \(crimes.count, privacy: .public) street level crimes in \(coordinates, privacy: .public) on \(date, privacy: .public)")

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
    public func crimes(forStreet streetID: Int, date: Date = Date()) async throws -> [Crime] {
        Self.logger.info("Fetching crimes for street \(streetID, privacy: .public) on \(date, privacy: .public)...")

        let crimes: [Crime]
        do {
            crimes = try await crimeRepository.crimes(forStreet: streetID, date: date)
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("Failed fetching crimes for street \(streetID, privacy: .public) on \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        // swiftlint:disable:next line_length
        Self.logger.info("Fetched \(crimes.count, privacy: .public) crimes for street \(streetID, privacy: .public) on \(date, privacy: .public)")

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
    public func crimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime] {
        Self.logger.info("Fetching crimes at \(coordinate, privacy: .public) on \(date, privacy: .public)...")

        let crimes: [Crime]
        do {
            crimes = try await crimeRepository.crimes(at: coordinate, date: date)
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("Failed fetching crimes at \(coordinate, privacy: .public) on \(date, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        Self.logger.info("Fetched \(crimes.count) crimes at \(coordinate, privacy: .public) on \(date, privacy: .public)...")

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
    public func crimesWithNoLocation(
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
    public func crimeCategories(forDate date: Date = Date()) async throws -> [CrimeCategory] {
        let categories = try await crimeRepository.crimeCategories(forDate: date)

        return categories
    }

}
