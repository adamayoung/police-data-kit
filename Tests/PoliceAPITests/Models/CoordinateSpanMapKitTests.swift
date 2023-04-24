#if canImport(MapKit)
import MapKit
@testable import PoliceAPI
import XCTest

final class CoordinateSpanMapKitTests: XCTestCase {

    func testMKCoordinateSpanReturnsCorrectMKCoordinateSpan() {
        let latitudeDelta: Double = 1.234
        let longitudeDelta: Double = 2.345
        let coordinateSpan = CoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)

        let mkCoordinateSpan = coordinateSpan.mkCoordinateSpan

        XCTAssertEqual(mkCoordinateSpan.latitudeDelta, latitudeDelta)
        XCTAssertEqual(mkCoordinateSpan.longitudeDelta, longitudeDelta)
    }

    func testPoliceAPICoordinateSpanReturnsCorrectPoliceAPICoordinateSpan() {
        let latitudeDelta: Double = 1.234
        let longitudeDelta: Double = 2.345
        let mkCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)

        let coordinateSpan = mkCoordinateSpan.policeAPICoordinateSpan

        XCTAssertEqual(coordinateSpan.latitudeDelta, latitudeDelta)
        XCTAssertEqual(coordinateSpan.longitudeDelta, longitudeDelta)
    }

}

#endif
