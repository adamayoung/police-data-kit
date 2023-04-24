#if canImport(CoreLocation)
import CoreLocation
@testable import PoliceAPI
import XCTest

final class CoordinateCoreLocationCoordinateTests: XCTestCase {

    func testCLCoordinateReturnsCorrectCLCoordinate() {
        let latitude: Double = 1.234
        let longitude: Double = 2.345
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)

        let clCoodinate = coordinate.clCoordinate

        XCTAssertEqual(clCoodinate.latitude, latitude)
        XCTAssertEqual(clCoodinate.longitude, longitude)
    }

    func testPoliceAPICoordinateReturnsCorrectCoordinate() {
        let latitude: Double = 1.234
        let longitude: Double = 2.345
        let clCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let coordinate = clCoordinate.policeAPICoordinate

        XCTAssertEqual(coordinate.latitude, latitude)
        XCTAssertEqual(coordinate.longitude, longitude)
    }

}
#endif
