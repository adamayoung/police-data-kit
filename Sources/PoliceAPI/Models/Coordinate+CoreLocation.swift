#if canImport(CoreLocation)
import CoreLocation
import Foundation

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
