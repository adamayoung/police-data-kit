import CoreLocation
import Foundation
@testable import PoliceDataKit

extension NeighbourhoodLocation {

    static var mock: Self {
        NeighbourhoodLocation(
            name: "Mansfield House",
            type: "station",
            address: "74 Belgrave Gate\n, Leicester",
            postcode: "LE1 3GG",
            coordinate: CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        )
    }

}
