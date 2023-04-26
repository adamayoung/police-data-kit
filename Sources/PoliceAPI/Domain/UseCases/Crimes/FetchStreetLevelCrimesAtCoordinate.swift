import Foundation

public final class FetchStreetLevelCrimesAtCoordinate: FetchStreetLevelCrimesAtCoordinateUseCase {

    typealias FetchStreetLevelCrimesAtCoordinate = (_ coordinate: Coordinate, _ date: Date) async throws -> [Crime]?

    private let streetLevelCrimesAtCoordinate: FetchStreetLevelCrimesAtCoordinate

    public convenience init(provider: some CrimeRepositoryProviding) {
        self.init(streetLevelCrimesAtCoordinate: provider.crimeRepository.streetLevelCrimes(atCoordinate:date:))
    }

    init(streetLevelCrimesAtCoordinate: @escaping FetchStreetLevelCrimesAtCoordinate) {
        self.streetLevelCrimesAtCoordinate = streetLevelCrimesAtCoordinate
    }

    public func execute(coordinate: Coordinate, date: Date) async throws -> [Crime]? {
        let crimes = try await streetLevelCrimesAtCoordinate(coordinate, date)

        return crimes
    }

}
