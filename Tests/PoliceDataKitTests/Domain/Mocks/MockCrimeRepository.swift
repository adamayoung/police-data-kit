import CoreLocation
import Foundation
@testable import PoliceDataKit

final class MockCrimeRepository: CrimeRepository {

    var streetLevelCrimesAtCoordinateResult: Result<[Crime], Error> = .failure(CrimeError.unknown)
    var lastStreetLevelCrimesAtCoordinateParameters: (coordinate: CLLocationCoordinate2D, date: Date)?

    var streetLevelCrimesInCoordinatesResult: Result<[Crime], Error> = .failure(CrimeError.unknown)
    var lastStreetLevelCrimesInCoordinatesParameters: (coordinates: [CLLocationCoordinate2D], date: Date)?

    var crimesForStreetResult: Result<[Crime], Error> = .failure(CrimeError.unknown)
    var lastCrimesForStreetResultParameters: (streetID: Int, date: Date)?

    var crimesAtCoordinateResult: Result<[Crime], Error> = .failure(CrimeError.unknown)
    var lastCrimesAtCoordinateParameters: (coordinate: CLLocationCoordinate2D, date: Date)?

    var crimesWithNoLocationForCategoryResult: Result<[Crime], Error> = .failure(CrimeError.unknown)
    // swiftlint:disable:next large_tuple
    var lastCrimesWithNoLocationForCategoryParameters: (category: CrimeCategory, policeForceID: PoliceForce.ID,
                                                        date: Date)?

    var crimeCategoriesResult: Result<[CrimeCategory], Error> = .failure(CrimeError.unknown)
    var lastCrimeCategoriesParameter: Date?

    init() { }

    func streetLevelCrimes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Crime] {
        lastStreetLevelCrimesAtCoordinateParameters = (coordinate: coordinate, date: date)

        return try streetLevelCrimesAtCoordinateResult.get()
    }

    func streetLevelCrimes(in coordinates: [CLLocationCoordinate2D], date: Date) async throws -> [Crime] {
        lastStreetLevelCrimesInCoordinatesParameters = (coordinates: coordinates, date: date)

        return try streetLevelCrimesAtCoordinateResult.get()
    }

    func crimes(forStreet streetID: Int, date: Date) async throws -> [Crime] {
        lastCrimesForStreetResultParameters = (streetID: streetID, date: date)

        return try crimesForStreetResult.get()
    }

    func crimes(at coordinate: CLLocationCoordinate2D, date: Date) async throws -> [Crime] {
        lastCrimesAtCoordinateParameters = (coordinate: coordinate, date: date)

        return try crimesAtCoordinateResult.get()
    }

    func crimesWithNoLocation(forCategory category: CrimeCategory, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date) async throws -> [Crime] {
        lastCrimesWithNoLocationForCategoryParameters = (category: category, policeForceID: policeForceID, date: date)

        return try crimesWithNoLocationForCategoryResult.get()
    }

    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory] {
        lastCrimeCategoriesParameter = date

        return try crimeCategoriesResult.get()
    }

}
