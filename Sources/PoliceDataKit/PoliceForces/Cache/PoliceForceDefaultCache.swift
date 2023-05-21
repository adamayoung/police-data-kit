import Foundation

final class PoliceForceDefaultCache: PoliceForceCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func policeForces() async -> [PoliceForceReference]? {
        let cacheKey = PoliceForcesCachingKey()
        let cachedPoliceForces = await cacheStore.object(for: cacheKey, type: [PoliceForceReference].self)

        return cachedPoliceForces
    }

    func setPoliceForces(_ policeForces: [PoliceForceReference]) async {
        let cacheKey = PoliceForcesCachingKey()

        await cacheStore.set(policeForces, for: cacheKey)
    }

    func policeForce(withID id: PoliceForce.ID) async -> PoliceForce? {
        let cacheKey = PoliceForceCachingKey(id: id)
        let cachedPoliceForce = await cacheStore.object(for: cacheKey, type: PoliceForce.self)

        return cachedPoliceForce
    }

    func setPoliceForce(_ policeForce: PoliceForce, withID id: PoliceForce.ID) async {
        let cacheKey = PoliceForceCachingKey(id: id)

        await cacheStore.set(policeForce, for: cacheKey)
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]? {
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        let cachedSeniorOfficers = await cacheStore.object(for: cacheKey, type: [PoliceOfficer].self)

        return cachedSeniorOfficers
    }

    func setSeniorOfficers(_ policeOfficers: [PoliceOfficer], inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)

        await cacheStore.set(policeOfficers, for: cacheKey)
    }

}
