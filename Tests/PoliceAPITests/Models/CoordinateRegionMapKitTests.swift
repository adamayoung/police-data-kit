#if canImport(MapKit)
import MapKit
@testable import PoliceAPI
import XCTest

final class CoordinateRegionMapKitTests: XCTestCase {

    func testMKCoordinateRegionReturnsCorrectMKCoordinateRegion() {
        let latitude: Double = 1.234
        let longitude: Double = 2.345
        let latitudeDelta: Double = 3.5
        let longitudeDelta: Double = 4.5
        let region = CoordinateRegion(
            center: Coordinate(latitude: latitude, longitude: longitude),
            span: CoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        )

        let mkCoordinateRegion = region.mkCoordinateRegion

        XCTAssertEqual(mkCoordinateRegion.center.latitude, latitude)
        XCTAssertEqual(mkCoordinateRegion.center.longitude, longitude)
        XCTAssertEqual(mkCoordinateRegion.span.latitudeDelta, latitudeDelta)
        XCTAssertEqual(mkCoordinateRegion.span.longitudeDelta, longitudeDelta)
    }

    func testPoliceAPICoordinateRegionReturnsCorrectCoordinateRegion() {
        let latitude: Double = 1.234
        let longitude: Double = 2.345
        let latitudeDelta: Double = 3.5
        let longitudeDelta: Double = 4.5
        let mkCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        )

        let coordinateRegion = mkCoordinateRegion.policeAPICoordinateRegion

        XCTAssertEqual(coordinateRegion.center.latitude, latitude)
        XCTAssertEqual(coordinateRegion.center.longitude, longitude)
        XCTAssertEqual(coordinateRegion.span.latitudeDelta, latitudeDelta)
        XCTAssertEqual(coordinateRegion.span.longitudeDelta, longitudeDelta)
    }

}
#endif
