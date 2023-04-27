import CoreLocation
@testable import PoliceDataKit
import XCTest

final class CrimeServiceTests: XCTestCase {

    var crimeService: CrimeService!
    var crimeRepository: MockCrimeRepository!

    override func setUp() {
        super.setUp()
        crimeRepository = MockCrimeRepository()
        crimeService = CrimeService(crimeRepository: crimeRepository)
    }

    override func tearDown() {
        crimeRepository = nil
        crimeService = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D(latitude: 1.1, longitude: 1.2)
        let date = Date()
        let expectedCrimes = Self.mockCrimes
        crimeRepository.streetLevelCrimesAtCoordinateResult = .success(expectedCrimes)

        let crimes = try await crimeService.streetLevelCrimes(at: coordinate, date: date)

        XCTAssertEqual(crimes, expectedCrimes)
        let parameters = crimeRepository.lastStreetLevelCrimesAtCoordinateParameters
        XCTAssertEqual(parameters?.coordinate.latitude, coordinate.latitude)
        XCTAssertEqual(parameters?.coordinate.longitude, coordinate.longitude)
        XCTAssertEqual(parameters?.date, date)
    }

}

extension CrimeServiceTests {

    private static var mockCrimes: [Crime] {
        [
            Crime(
                id: 1,
                crimeID: "A",
                categoryID: "cat-1",
                location: Location(
                    street: Location.Street(
                        id: 1,
                        name: "street-1"
                    ),
                    coordinate: CLLocationCoordinate2D(latitude: 1.1, longitude: 1.2)
                ),
                locationType: .force,
                date: Date()
            ),
            Crime(
                id: 2,
                crimeID: "B",
                categoryID: "cat-2",
                location: Location(
                    street: Location.Street(
                        id: 2,
                        name: "street-2"
                    ),
                    coordinate: CLLocationCoordinate2D(latitude: 2.1, longitude: 2.2)
                ),
                locationType: .britishTransportPolice,
                date: Date()
            )
        ]
    }

}
