@testable import PoliceAPI
import XCTest

final class CoordinateRegionDataModelContainsTests: XCTestCase {

    var region: CoordinateRegionDataModel!

    override func setUp() {
        super.setUp()
        region = CoordinateRegionDataModel(
            center: CoordinateDataModel(latitude: 0, longitude: 0),
            span: CoordinateSpanDataModel(latitudeDelta: 1, longitudeDelta: 1)
        )
    }

    override func tearDown() {
        region = nil
        super.tearDown()
    }

    func testContainsWhenCoordinateIsNorthOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: -2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthEastOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: -2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsEastOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: 0, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthEastOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: 2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: 2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthWestOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: 2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsWestOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: 0, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthWestOfRegionReturnsFalse() {
        let coordinate = CoordinateDataModel(latitude: -2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsInCenterOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: -0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthEastInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: -0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsEastInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthEastInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthWestInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsWestInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: 0, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthWestInsideOfRegionReturnsTrue() {
        let coordinate = CoordinateDataModel(latitude: -0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

}
