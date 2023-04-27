import CoreLocation
import Foundation

extension CLLocationCoordinate2D {

    static var mock: Self {
        CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
    }

    static var outsideAvailableDataRegion: Self {
        CLLocationCoordinate2D(latitude: 32.6389, longitude: 4.13619)
    }

}
