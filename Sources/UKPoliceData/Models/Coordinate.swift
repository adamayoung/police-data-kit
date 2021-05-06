import Foundation

/// Coordinate.
public struct Coordinate: Decodable, Equatable {

    /// Latitude.
    public let latitude: String
    /// Longitude.
    public let longitude: String

    public init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }

}
