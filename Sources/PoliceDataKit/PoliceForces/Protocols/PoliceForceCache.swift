import Foundation

protocol PoliceForceCache {

    func policeForces() async -> [PoliceForceReference]?

    func setPoliceForces(_ policeForces: [PoliceForceReference]) async

    func policeForce(withID id: PoliceForce.ID) async -> PoliceForce?

    func setPoliceForce(_ policeForce: PoliceForce, withID id: PoliceForce.ID) async

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]?

    func setSeniorOfficers(_ policeOfficers: [PoliceOfficer], inPoliceForce policeForceID: PoliceForce.ID) async

}
