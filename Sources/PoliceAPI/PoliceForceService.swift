import CoreLocation
import Foundation

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

    private let policeForceRepository: any PoliceForceRepository

    ///
    /// Creates a police force service object.
    ///
    /// Use this method to create different `PoliceForceService` instances. If you only need one instance of
    /// `PoliceForceService`, use `shared`.
    ///
    public convenience init() {
        self.init(policeForceRepository: PoliceAPIFactory.policeForceRepository())
    }

    init(policeForceRepository: some PoliceForceRepository) {
        self.policeForceRepository = policeForceRepository
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
        let policeForces = try await policeForceRepository.policeForces()

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
    public func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce? {
        let policeForce = try await policeForceRepository.policeForce(withID: id)

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
    public func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer]? {
        let policeOfficers = try await policeForceRepository.seniorOfficers(inPoliceForce: policeForceID)

        return policeOfficers
    }

}
