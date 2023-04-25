import Foundation

/// Get information about Police Forces and their Senior Officers.
public protocol PoliceForceRepository {

    /// Returns a list of all the police forces available except the British Transport Police, which is excluded from
    /// the list returned. Unique force identifiers obtained here are used in requests for force-specific data via
    /// other methods.
    ///
    /// - Note: [Police API | List of forces](https://data.police.uk/docs/method/forces/)
    ///
    /// - Returns: A list of Police Forces.
    func policeForces() async throws -> [PoliceForceReference]

    /// Returns a specific Police Force.
    ///
    /// - Note: [Police API | Specific force](https://data.police.uk/docs/method/force/)
    ///
    /// - Parameters:
    ///   - id: Police Force identifier.
    ///
    /// - Returns: The matching Police Force.
    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce?

    /// Returns the Senior Police Officers in a Police Force.
    ///
    /// - Note: [Police API | Senior officers](https://data.police.uk/docs/method/senior-officers/)
    ///
    /// - Parameters:
    ///   - id: Police Force identifier.
    ///
    /// - Returns: A list of Senior Police Officers.
    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer]?

}

public protocol PoliceForceRepositoryProviding {

    var policeForceRepository: PoliceForceRepository { get}

}
