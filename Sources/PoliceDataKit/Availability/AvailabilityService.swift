import Foundation
import os

///
/// Provides an interface for obtaining availability data sets from the UK Police API.
///
public final class AvailabilityService {

    ///
    /// A single, shared availability service object.
    ///
    /// Use this object to interface to availability services in your application.
    ///
    public static let shared = AvailabilityService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "AvailabilityService")

    private let apiClient: any APIClient
    private let cache: any Cache

    ///
    /// Creates an availability service object.
    ///
    /// Use this method to create different `AvailabilityService` instances. If you only need one instance of
    /// `AvailabilityService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.cache
        )
    }

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    ///
    /// Returns the available data sets.
    ///
    /// [https://data.police.uk/docs/method/crimes-street-dates/](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Throws: Availability data error ``AvailabilityError``.
    ///
    /// - Returns: The available data sets.
    ///
    public func availableDataSets() async throws -> [DataSet] {
        Self.logger.trace("fetching available data sets")

        let cacheKey = AvailableDataSetsCachingKey()
        if let cachedDataSets = await cache.object(for: cacheKey, type: [DataSet].self) {
            return cachedDataSets
        }

        let dataSets: [DataSet]
        do {
            dataSets = try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
        } catch let error {
            Self.logger.error("failed fetching available data sets: \(error.localizedDescription)")
            throw Self.mapToAvailabilityError(error)
        }

        await cache.set(dataSets, for: cacheKey)

        return dataSets
    }

}

extension AvailabilityService {

    private static func mapToAvailabilityError(_ error: Error) -> AvailabilityError {
        guard let error = error as? APIClientError else {
            return .unknown
        }

        switch error {
        case .network:
            return .network(error)

        case .notFound, .decode, .unknown:
            return .unknown
        }
    }

}
