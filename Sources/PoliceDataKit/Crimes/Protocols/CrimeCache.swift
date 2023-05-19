import CoreLocation
import Foundation

protocol CrimeCache {

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]?

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async

    func crimesWithNoLocation(forCategory categoryID: CrimeCategory.ID, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date) async -> [Crime]?

    func setCrimesWithNoLocation(_ crimes: [Crime], forCategory categoryID: CrimeCategory.ID,
                                 inPoliceForce policeForceID: PoliceForce.ID, date: Date) async

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]?

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async

}
