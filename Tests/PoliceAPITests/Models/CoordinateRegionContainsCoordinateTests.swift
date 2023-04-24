@testable import PoliceAPI
import XCTest

final class CoordinateRegionContainsTests: XCTestCase {

    var region: CoordinateRegion!

    override func setUp() {
        super.setUp()
        region = CoordinateRegion(
            center: Coordinate(latitude: 0, longitude: 0),
            span: CoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    }

    override func tearDown() {
        region = nil
        super.tearDown()
    }

    func testContainsWhenCoordinateIsNorthOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: -2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthEastOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: -2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsEastOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: 0, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthEastOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: 2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: 2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthWestOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: 2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsWestOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: 0, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthWestOfRegionReturnsFalse() {
        let coordinate = Coordinate(latitude: -2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsInCenterOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: -0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthEastInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: -0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsEastInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthEastInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthWestInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsWestInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: 0, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthWestInsideOfRegionReturnsTrue() {
        let coordinate = Coordinate(latitude: -0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

}
