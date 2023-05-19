import Foundation
@testable import PoliceDataKit

final class CrimeMockCache: CrimeCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func crimesForStreet(streetID: Int, date: Date) -> String {
            "crimes-for-street-\(streetID)-\(date)"
        }

        static func crimesWithNoLocation(categoryID: CrimeCategory.ID, policeForceID: PoliceForce.ID,
                                         date: Date) -> String {
            "crimes-with-no-location-\(categoryID)-\(policeForceID)-\(date)"
        }
        static func crimeCategories(date: Date) -> String {
            "crime-categories-\(date)"
        }

    }

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]? {
        cacheStore[CacheKey.crimesForStreet(streetID: streetID, date: date)] as? [Crime]
    }

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async {
        cacheStore[CacheKey.crimesForStreet(streetID: streetID, date: date)] = crimes
    }

    func crimesWithNoLocation(forCategory categoryID: CrimeCategory.ID, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date) async -> [Crime]? {
        let key = CacheKey.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date)
        return cacheStore[key] as? [Crime]
    }

    func setCrimesWithNoLocation(_ crimes: [Crime], forCategory categoryID: CrimeCategory.ID,
                                 inPoliceForce policeForceID: PoliceForce.ID, date: Date) async {
        let key = CacheKey.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date)
        cacheStore[key] = crimes
    }

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]? {
        cacheStore[CacheKey.crimeCategories(date: date)] as? [CrimeCategory]
    }

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async {
        cacheStore[CacheKey.crimeCategories(date: date)] = crimeCategories
    }

}
