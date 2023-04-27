import Foundation
@testable import PoliceDataKit

final class MockPoliceForceRepository: PoliceForceRepository {

    var policeForcesResult: Result<[PoliceForceReference], Error> = .failure(PoliceForceError.unknown)

    var policeForceResult: Result<PoliceForce, Error> = .failure(PoliceForceError.unknown)
    var lastPoliceForceParameter: PoliceForce.ID?

    var seniorOfficersResult: Result<[PoliceOfficer], Error> = .failure(PoliceForceError.unknown)
    var lastSeniorOfficersParameter: PoliceForce.ID?

    init() { }

    func policeForces() async throws -> [PoliceForceReference] {
        try policeForcesResult.get()
    }

    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce {
        lastPoliceForceParameter = id

        return try policeForceResult.get()
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        lastSeniorOfficersParameter = policeForceID

        return try seniorOfficersResult.get()
    }

}
