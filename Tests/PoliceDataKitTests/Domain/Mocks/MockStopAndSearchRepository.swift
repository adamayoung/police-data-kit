import CoreLocation
import Foundation
@testable import PoliceDataKit

final class MockStopAndSearchRepository: StopAndSearchRepository {

    var stopAndSearchesAtCoordinateResult: Result<[StopAndSearch], Error> = .failure(StopAndSearchError.unknown)
    var lastStopAndSearchesAtCoordinateParameters: (coordinate: CLLocationCoordinate2D, date: Date)?

    var stopAndSearchesInCoordinatesResult: Result<[StopAndSearch], Error> = .failure(StopAndSearchError.unknown)
    var lastStopAndSearchesInCoordinatesParameters: (coordinates: [CLLocationCoordinate2D], date: Date)?

    var stopAndSearchesAtLocationResult: Result<[StopAndSearch], Error> = .failure(StopAndSearchError.unknown)
    var lastStopAndSearchesAtLocation: (streetID: Int, date: Date)?

    var stopAndSearchesWithNoLocationResult: Result<[StopAndSearch], Error> = .failure(StopAndSearchError.unknown)
    var lastStopAndSearchesWithNoLocationParameters: (policeForceID: PoliceForce.ID, date: Date)?

    var stopAndSearchesForPoliceForceResult: Result<[StopAndSearch], Error> = .failure(StopAndSearchError.unknown)
    var lastStopAndSearchesForPoliceForceParameters: (policeForceID: PoliceForce.ID, date: Date)?

    init() { }

    func stopAndSearches(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [StopAndSearch] {
        lastStopAndSearchesAtCoordinateParameters = (coordinate: coordinate, date: date)

        return try stopAndSearchesAtCoordinateResult.get()
    }

    func stopAndSearches(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [StopAndSearch] {
        lastStopAndSearchesInCoordinatesParameters = (coordinates: coordinates, date: date)

        return try stopAndSearchesInCoordinatesResult.get()
    }

    func stopAndSearches(atLocation streetID: Int, date: Date) async throws -> [StopAndSearch] {
        lastStopAndSearchesAtLocation = (streetID: streetID, date: date)

        return try stopAndSearchesAtLocationResult.get()
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async throws -> [StopAndSearch] {
        lastStopAndSearchesWithNoLocationParameters = (policeForceID: policeForceID, date: date)

        return try stopAndSearchesWithNoLocationResult.get()
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async throws -> [StopAndSearch] {
        lastStopAndSearchesForPoliceForceParameters = (policeForceID: policeForceID, date: date)

        return try stopAndSearchesForPoliceForceResult.get()
    }

}
