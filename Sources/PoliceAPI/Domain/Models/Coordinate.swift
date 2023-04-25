import Foundation

/// Coordinate.
public struct Coordinate: Equatable, CustomStringConvertible {

    /// Latitude.
    public var latitude: Double
    /// Longitude.
    public var longitude: Double

    /// Creates a new `Coordinate`.
    ///
    /// - Parameters:
    ///   - latitude: Latitude.
    ///   - longitude: Longitude.
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public var description: String {
        "(\(latitude), \(longitude))"
    }

}
