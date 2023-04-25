import Foundation

public protocol FetchStreetLevelCrimesAtCoordinateUseCase {

    func execute(coordinate: Coordinate, date: Date) async throws -> [Crime]?

}
