import Foundation
import os

///
/// Provides an interface for obtaining availability data sets from the UK Police Data API.
///
public final class AvailabilityService {

    ///
    /// A single, shared availability service object.
    ///
    /// Use this object to interface to availability services in your application.
    /// 
    public static let shared = AvailabilityService()

    private static let logger = Logger(subsystem: Logger.domainSubsystem, category: "AvailabilityService")

    private let availabilityRepository: any AvailabilityRepository

    ///
    /// Creates an availability service object.
    ///
    /// Use this method to create different `AvailabilityService` instances. If you only need one instance of
    /// `AvailabilityService`, use `shared`.
    ///
    public convenience init() {
        self.init(availabilityRepository: PoliceDataKitFactory.availabilityRepository())
    }

    init(availabilityRepository: some AvailabilityRepository) {
        self.availabilityRepository = availabilityRepository
    }

    ///
    /// Returns the available data sets.
    ///
    /// [https://data.police.uk/docs/method/crimes-street-dates/](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Throws: Availability data error `AvailabilityError`.
    /// 
    /// - Returns: The available data sets.
    ///
    public func availableDataSets() async throws -> [DataSet] {
        Self.logger.info("Fetching available data sets...")

        let dataSets: [DataSet]
        do {
            dataSets = try await availabilityRepository.availableDataSets()
        } catch let error {
            Self.logger.error("Failed fetched available data sets: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let sortedDataSets = dataSets.sorted { $0.date < $1.date }

        Self.logger.info("Fetched \(dataSets.count) data sets")

        return sortedDataSets
    }

}
