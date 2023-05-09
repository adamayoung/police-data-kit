import CoreLocation
import Foundation

///
/// A model representing a neighbourhood location.
///
public struct NeighbourhoodLocation: Equatable, Codable {

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

extension NeighbourhoodLocation {

    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case description
        case address
        case postcode
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.address = try container.decode(String.self, forKey: .address)
        self.postcode = try container.decodeIfPresent(String.self, forKey: .postcode)
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
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(postcode, forKey: .postcode)
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
    }

}
