import CoreLocation
import Foundation

extension CLLocationCoordinate2D {

    static var mock: Self {
        CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
    }

    static var mocks: [Self] {
        [
            CLLocationCoordinate2D(
                latitude: 52.6394052587,
                longitude: -1.1458618876
            ),
            CLLocationCoordinate2D(
                latitude: 52.6389452755,
                longitude: -1.1457057759
            ),
            CLLocationCoordinate2D(
                latitude: 52.6383706746,
                longitude: -1.1455755443
            )
        ]
    }

    static var outsideAvailableDataRegion: Self {
        CLLocationCoordinate2D(latitude: 32.6389, longitude: 4.13619)
    }

}
