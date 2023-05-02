import CoreLocation
import Foundation

///
/// A model representing a location.
///
public struct Location: Equatable {

    /// An approximate street for the location.
    ///
    /// This is only an approximation of where the crime happened.
    public let street: Street

    /// Location coordinate.
    public var coordinate: CLLocationCoordinate2D?

    ///
    /// Creates a location object.
    ///
    /// - Parameters:
    ///   - street: An approximate street for the location.
    ///   - coordinate: Location coordinate.
    ///  
    public init(street: Street, coordinate: CLLocationCoordinate2D) {
        self.street = street
        self.coordinate = coordinate
    }

}
