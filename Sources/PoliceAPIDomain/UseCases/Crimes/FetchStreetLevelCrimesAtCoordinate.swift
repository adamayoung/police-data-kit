import Foundation

public final class FetchStreetLevelCrimesAtCoordinate: FetchStreetLevelCrimesAtCoordinateUseCase {

    private let streetLevelCrimesAtCoordinate: (_ coordinate: Coordinate, _ date: Date) async throws -> [Crime]?

    public convenience init(provider: CrimeRepositoryProviding) {
        self.init(streetLevelCrimesAtCoordinate: provider.crimeRepository.streetLevelCrimes(atCoordinate:date:))
    }

    init(streetLevelCrimesAtCoordinate: @escaping (_ coordinate: Coordinate, _ date: Date) async throws -> [Crime]?) {
        self.streetLevelCrimesAtCoordinate = streetLevelCrimesAtCoordinate
    }

    public func execute(coordinate: Coordinate, date: Date) async throws -> [Crime]? {
        let crimes = try await streetLevelCrimesAtCoordinate(coordinate, date)

        return crimes
    }

}
