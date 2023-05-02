import CoreLocation
import Foundation

///
/// A model representing a neighbourhood location.
///
public struct NeighbourhoodLocation: Equatable {

    /// Name.
    public let name: String?

    /// Type of location.
    ///
    /// e.g. 'station' (police station)
    public let type: String?

    /// Description.
    public let description: String?

    /// Location address.
    public let address: String

    /// Postcode.
    public let postcode: String?

    /// Location coordinate.
    public var coordinate: CLLocationCoordinate2D?

    ///
    /// Creates a neighbourhood object.
    ///
    /// - Parameters:
    ///   - name: Name.
    ///   - type: Type of location.
    ///   - description: Description.
    ///   - address: Location address.
    ///   - postcode: Postcode.
    ///   - coordinate: Location coordinate.
    ///
    public init(
        name: String? = nil,
        type: String? = nil,
        description: String? = nil,
        address: String,
        postcode: String? = nil,
        coordinate: CLLocationCoordinate2D? = nil
    ) {
        self.name = name
        self.type = type
        self.description = description
        self.address = address
        self.postcode = postcode
        self.coordinate = coordinate
    }

}
