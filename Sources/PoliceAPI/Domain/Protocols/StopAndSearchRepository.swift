import CoreLocation
import Foundation

protocol StopAndSearchRepository {

    func stopAndSearches(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [StopAndSearch]?

    func stopAndSearches(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [StopAndSearch]

    func stopAndSearches(atLocation streetID: Int, date: Date) async throws -> [StopAndSearch]

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async throws -> [StopAndSearch]

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async throws -> [StopAndSearch]

}
