import CoreLocation
import Foundation

///
/// A model representing a location.
///
public struct Location: Equatable, Codable {

    /// An approximate street for the location.
    ///
    /// This is only an approximation of where the crime happened.
    public let street: Street

    /// Location coordinate.
    public let coordinate: CLLocationCoordinate2D?

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

extension Location {

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case street
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let latitudeString = try container.decodeIfPresent(String.self, forKey: .latitude)
        let longitudeString = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.coordinate = {
            guard
                let latitudeString,
                let longitudeString,
                let latitude = Double(latitudeString),
                let longitude = Double(longitudeString)
            else {
                return nil
            }

            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }()

        self.street = try container.decode(Street.self, forKey: .street)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let latitudeString: String? = {
            guard let coordinate else {
                return nil
            }

            return String(coordinate.latitude)
        }()

        let longitudeString: String? = {
            guard let coordinate else {
                return nil
            }

            return String(coordinate.longitude)
        }()

        try container.encodeIfPresent(latitudeString, forKey: .latitude)
        try container.encodeIfPresent(longitudeString, forKey: .latitude)
        try container.encode(street, forKey: .street)
    }

}
