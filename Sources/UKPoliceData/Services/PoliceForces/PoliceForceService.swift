import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about Police Forces and their Senior Officers.
public protocol PoliceForceService {

    /// Fetches a list of all the police forces available except the British Transport Police, which is excluded from
    /// the list returned. Unique force identifiers obtained here are used in requests for force-specific data via
    /// other methods.
    ///
    /// - Note: [Police API | List of forces](https://data.police.uk/docs/method/forces/)
    ///
    /// - Parameters:
    ///     - completion: Completion handler.
    ///     - result: A list of Police Forces.
    func fetchAll(completion: @escaping (_ result: Result<[PoliceForceReference], PoliceDataError>) -> Void)

    /// Fetches a specific Police Force.
    ///
    /// - Note: [Police API | Specific force](https://data.police.uk/docs/method/force/)
    ///
    /// - Parameters:
    ///     - id: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: The matching Police Force.
    func fetchDetails(forPoliceForce id: String,
                      completion: @escaping (_ result: Result<PoliceForce, PoliceDataError>) -> Void)

    /// Fetches the Senior Police Officers for a Police Force.
    ///
    /// - Note: [Police API | Senior officers](https://data.police.uk/docs/method/senior-officers/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: A list of Senior Police Officers.
    func fetchSeniorOfficers(forPoliceForce policeForceID: String,
                             completion: @escaping (_ result: Result<[PoliceOfficer], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of all the police forces available except the British Transport Police, which is excluded from
    /// the list returned. Unique force identifiers obtained here are used in requests for force-specific data via other
    /// methods.
    ///
    /// - Note: [Police API | List of forces](https://data.police.uk/docs/method/forces/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A publisher with a list of Police Forces.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func policeForcesPublisher() -> AnyPublisher<[PoliceForceReference], PoliceDataError>

    /// Publishes a specific Police Force.
    ///
    /// - Note: [Police API | Specific force](https://data.police.uk/docs/method/force/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A publisher with the matching Police Force.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func detailsPublisher(forPoliceForce policeForceID: String) -> AnyPublisher<PoliceForce, PoliceDataError>

    /// Publishes the Senior Police Officers for a Police Force.
    ///
    /// - Note: [Police API | Senior officers](https://data.police.uk/docs/method/senior-officers/)
    /// 
    /// - Returns: A publisher with a list of Senior Police Officers.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func seniorOfficersPublisher(forPoliceForce policeForceID: String) -> AnyPublisher<[PoliceOfficer], PoliceDataError>
    #endif

}

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension PoliceForceService {

    /// Returns a list of all the police forces available except the British Transport Police, which is excluded from
    /// the list returned. Unique force identifiers obtained here are used in requests for force-specific data via
    /// other methods.
    ///
    /// - Note: [Police API | List of forces](https://data.police.uk/docs/method/forces/)
    ///
    /// - Returns: A list of Police Forces.
    func all() async throws -> [PoliceForceReference] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(completion: continuation.resume(with:))
        }
    }

    /// Returns a specific Police Force.
    ///
    /// - Note: [Police API | Specific force](https://data.police.uk/docs/method/force/)
    ///
    /// - Parameters:
    ///     - id: Police Force identifier.
    ///
    /// - Returns: The matching Police Force.
    func details(forPoliceForce id: String) async throws -> PoliceForce {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchDetails(forPoliceForce: id, completion: continuation.resume(with:))
        }
    }

    /// Returns the Senior Police Officers for a Police Force.
    ///
    /// - Note: [Police API | Senior officers](https://data.police.uk/docs/method/senior-officers/)
    ///
    /// - Parameters:
    ///     - id: Police Force identifier.
    ///
    /// - result: A list of Senior Police Officers.
    func seniorOfficers(forPoliceForce policeForceID: String) async throws -> [PoliceOfficer] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchSeniorOfficers(forPoliceForce: policeForceID, completion: continuation.resume(with:))
        }
    }

}
#endif
