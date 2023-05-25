import CoreLocation
import Foundation

extension CLLocationCoordinate2D: CustomStringConvertible {

    public var description: String {
        "(\(latitude), \(longitude))"
    }

}
