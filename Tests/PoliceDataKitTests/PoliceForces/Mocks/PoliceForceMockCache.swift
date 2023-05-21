import Foundation
@testable import PoliceDataKit

final class PoliceForceMockCache: PoliceForceCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static let policeForces = "police-forces"

        static func policeForce(id: PoliceForce.ID) -> String {
            "police-force-\(id)"
        }

        static func seniorOfficers(policeForceID: PoliceForce.ID) -> String {
            "senior-officers-\(policeForceID)"
        }

    }

    func policeForces() async -> [PoliceForceReference]? {
        cacheStore[CacheKey.policeForces] as? [PoliceForceReference]
    }

    func setPoliceForces(_ policeForces: [PoliceForceReference]) async {
        cacheStore[CacheKey.policeForces] = policeForces
    }

    func policeForce(withID id: PoliceForce.ID) async -> PoliceForce? {
        cacheStore[CacheKey.policeForce(id: id)] as? PoliceForce
    }

    func setPoliceForce(_ policeForce: PoliceForce, withID id: PoliceForce.ID) async {
        cacheStore[CacheKey.policeForce(id: id)] = policeForce
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]? {
        cacheStore[CacheKey.seniorOfficers(policeForceID: policeForceID)] as? [PoliceOfficer]
    }

    func setSeniorOfficers(_ policeOfficers: [PoliceOfficer], inPoliceForce policeForceID: PoliceForce.ID) async {
        cacheStore[CacheKey.seniorOfficers(policeForceID: policeForceID)] = policeOfficers
    }

}
