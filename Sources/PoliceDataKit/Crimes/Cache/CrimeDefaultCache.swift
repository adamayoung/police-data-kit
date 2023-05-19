import CoreLocation
import Foundation

final actor CrimeDefaultCache: CrimeCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]? {
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let cachedCrimes = await cacheStore.object(for: cacheKey, type: [Crime].self)

        return cachedCrimes
    }

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async {
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)

        await cacheStore.set(crimes, for: cacheKey)
    }

    func crimesWithNoLocation(forCategory categoryID: CrimeCategory.ID, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date) async -> [Crime]? {
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        let cachedCrimes = await cacheStore.object(for: cacheKey, type: [Crime].self)

        return cachedCrimes
    }

    func setCrimesWithNoLocation(_ crimes: [Crime], forCategory categoryID: CrimeCategory.ID,
                                 inPoliceForce policeForceID: PoliceForce.ID, date: Date) async {
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)

        await cacheStore.set(crimes, for: cacheKey)
    }

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]? {
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let cachedCrimeCategories = await cacheStore.object(for: cacheKey, type: [CrimeCategory].self)

        return cachedCrimeCategories
    }

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async {
        let cacheKey = CrimeCategoriesCachingKey(date: date)

        await cacheStore.set(crimeCategories, for: cacheKey)
    }

}
