import CoreLocation
import Foundation

protocol OutcomeRepository {

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async throws -> [Outcome]

    func streetLevelOutcomes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Outcome]

    func streetLevelOutcomes(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [Outcome]

    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory

}
