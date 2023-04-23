import Foundation

/// Coordinate.
public struct Coordinate: Decodable, Equatable, CustomStringConvertible {

    /// Latitude.
    public var latitude: Double {
        Double(latitudeString) ?? 0
    }
    /// Longitude.
    public var longitude: Double {
        Double(longitudeString) ?? 0
    }

    private let latitudeString: String
    private let longitudeString: String

    /// Creates a new `Coordinate`.
    ///
    /// - Parameters:
    ///   - latitude: Latitude.
    ///   - longitude: Longitude.
    public init(latitude: Double, longitude: Double) {
        self.latitudeString = String(latitude)
        self.longitudeString = String(longitude)
    }

    public var description: String {
        "(\(latitude), \(longitude))"
    }

}

extension Coordinate {

    private enum CodingKeys: String, CodingKey {
        case latitudeString = "latitude"
        case longitudeString = "longitude"
    }

}
