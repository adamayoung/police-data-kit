import CoreLocation
import Foundation

protocol CrimeRepository {

    func streetLevelCrimes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Crime]

    func streetLevelCrimes(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [Crime]

    func crimes(forStreet streetID: Int, date: Date) async throws -> [Crime]

    func crimes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Crime]

    func crimesWithNoLocation(forCategory category: CrimeCategory, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date) async throws -> [Crime]

    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory]

}
