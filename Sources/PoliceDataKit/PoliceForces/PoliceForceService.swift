import Foundation
import os

///
/// Provides an interface for obtaining police force data from the UK Police Data API.
///
public final class PoliceForceService {

    ///
    /// A single, shared police force service object.
    ///
    /// Use this object to interface to police force services in your application.
    ///
    public static let shared = PoliceForceService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "PoliceForceService")

    private let apiClient: any APIClient
    private let cache: any Cache

    ///
    /// Creates a police force service object.
    ///
    /// Use this method to create different `PoliceForceService` instances. If you only need one instance of
    /// `PoliceForceService`, use `shared`.
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
    /// Returns a list of all the police forces available except the British Transport Police, which is excluded from
    /// the list returned. Unique force identifiers obtained here are used in requests for force-specific data via
    /// other methods.
    ///
    /// [https://data.police.uk/docs/method/forces/](https://data.police.uk/docs/method/forces/)
    ///
    /// - Throws: Police Force data error `PoliceForceError`.
    ///
    /// - Returns: All Police Forces.
    ///
    public func policeForces() async throws -> [PoliceForceReference] {
        Self.logger.trace("fetching Police Forces")

        let cacheKey = PoliceForcesCachingKey()
        if let cachedPoliceForces = await cache.object(for: cacheKey, type: [PoliceForceReference].self) {
            return cachedPoliceForces
        }

        let policeForces: [PoliceForceReference]
        do {
            policeForces = try await apiClient.get(endpoint: PoliceForcesEndpoint.list)
        } catch let error {
            Self.logger.error("failed fetching Police Forces: \(error.localizedDescription, privacy: .public)")
            throw Self.mapToPoliceForceError(error)
        }

        await cache.set(policeForces, for: cacheKey)

        return policeForces
    }

    ///
    /// Returns a specific Police Force.
    ///
    /// [https://data.police.uk/docs/method/force/](https://data.police.uk/docs/method/force/)
    ///
    /// - Parameter id: Police Force identifier.
    ///
    /// - Throws: Police Force data error `PoliceForceError`.
    ///
    /// - Returns: The Police Force specified.
    ///
    public func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce {
        Self.logger.trace("fetching Police Force \(id, privacy: .public)")

        let cacheKey = PoliceForceCachingKey(id: id)
        if let cachedPoliceForce = await cache.object(for: cacheKey, type: PoliceForce.self) {
            return cachedPoliceForce
        }

        let policeForce: PoliceForce
        do {
            policeForce = try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Police Force \(id, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToPoliceForceError(error)
        }

        await cache.set(policeForce, for: cacheKey)

        return policeForce
    }

    ///
    /// Returns the Senior Police Officers in a Police Force.
    ///
    /// [https://data.police.uk/docs/method/senior-officers/](https://data.police.uk/docs/method/senior-officers/)
    ///
    /// - Parameter id: Police Force identifier.
    ///
    /// - Throws: Police Force data error `PoliceForceError`.
    ///
    /// - Returns: Senior Police Officers for the specified Police Force..
    ///
    public func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        Self.logger.trace("fetching Senior Officers in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        if let cachedPeopleOfficers = await cache.object(for: cacheKey, type: [PoliceOfficer].self) {
            return cachedPeopleOfficers
        }

        let policeOfficers: [PoliceOfficer]
        do {
            policeOfficers = try await apiClient.get(
                endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Senior Officers in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToPoliceForceError(error)
        }

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

}

extension PoliceForceService {

    private static func mapToPoliceForceError(_ error: Error) -> PoliceForceError {
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
