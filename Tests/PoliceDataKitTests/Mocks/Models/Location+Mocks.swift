import CoreLocation
import Foundation
@testable import PoliceDataKit

extension Location {

    static var mock: Self {
        Location(
            street: Street(
                id: 883425,
                name: "On or near Peacock Lane"
            ),
            coordinate: CLLocationCoordinate2D(latitude: 52.633888, longitude: -1.138924)

        )
    }

}
