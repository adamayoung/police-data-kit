import CoreLocation
import Foundation
@testable import PoliceDataKit

final class MockOutcomeRepository: OutcomeRepository {

    var streetLevelOutcomesForStreetResult: Result<[Outcome], Error> = .failure(OutcomeError.unknown)
    var lastStreetLevelOutcomesParameters: (streetID: Int, date: Date)?

    var streetLevelOutcomesAtCoordinateResult: Result<[Outcome], Error> = .failure(OutcomeError.unknown)
    var lastStreetLevelOutcomesAtCoordinateParameters: (coordinate: CLLocationCoordinate2D, date: Date)?

    var streetLevelOutcomesInCoordinatesResult: Result<[Outcome], Error> = .failure(OutcomeError.unknown)
    var lastStreetLevelOutcomesInCoordinatesParameters: (coordinates: [CLLocationCoordinate2D], date: Date)?

    var caseHistoryResult: Result<CaseHistory, Error> = .failure(OutcomeError.unknown)
    var lastCaseHistoryParameter: String?

    init() { }

    func streetLevelOutcomes(forStreet streetID: Int, date: Date) async throws -> [Outcome] {
        lastStreetLevelOutcomesParameters = (streetID: streetID, date: date)

        return try streetLevelOutcomesForStreetResult.get()
    }

    func streetLevelOutcomes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Outcome] {
        lastStreetLevelOutcomesAtCoordinateParameters = (coordinate: coordinate, date: date)

        return try streetLevelOutcomesAtCoordinateResult.get()
    }

    func streetLevelOutcomes(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [Outcome] {
        lastStreetLevelOutcomesInCoordinatesParameters = (coordinates: coordinates, date: date)

        return try streetLevelOutcomesInCoordinatesResult.get()
    }

    func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        lastCaseHistoryParameter = crimeID

        return try caseHistoryResult.get()
    }

}
