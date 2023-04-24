#if canImport(CoreLocation)
import Foundation
import CoreLocation

extension Coordinate {

    public var clCoordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }

}

extension CLLocationCoordinate2D {

    public var policeAPICoordinate: Coordinate {
        .init(latitude: latitude, longitude: longitude)
    }

}
#endif
