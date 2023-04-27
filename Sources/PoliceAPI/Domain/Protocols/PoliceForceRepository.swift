import Foundation

protocol PoliceForceRepository {

    func policeForces() async throws -> [PoliceForceReference]

    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer]

}
