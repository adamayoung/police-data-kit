import Foundation

#if canImport(CoreLocation)
import CoreLocation
#endif

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

    /// Creates a a new `Coordinate`.
    ///
    /// - Parameters:
    ///     - latitude: Latitude.
    ///     - longitude: Longitude.
    public init(latitude: Double, longitude: Double) {
        self.latitudeString = String(latitude)
        self.longitudeString = String(longitude)
    }

    public var description: String {
        "(\(latitude), \(longitude))"
    }

}

#if canImport(CoreLocation)
extension Coordinate {

    public var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

}
#endif

extension Coordinate {

    private enum CodingKeys: String, CodingKey {
        case latitudeString = "latitude"
        case longitudeString = "longitude"
    }

}
