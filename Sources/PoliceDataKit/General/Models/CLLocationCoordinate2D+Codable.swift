import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Codable {

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        let longitudeString = try container.decode(String.self, forKey: .longitude)

        guard let latitude = Double(latitudeString) else {
            let context = DecodingError.Context(
                codingPath: container.codingPath + [CodingKeys.latitude],
                debugDescription: "Could not parse latitude to a Double"
            )
            throw DecodingError.dataCorrupted(context)
        }

        guard let longitude = Double(longitudeString) else {
            let context = DecodingError.Context(
                codingPath: container.codingPath + [CodingKeys.longitude],
                debugDescription: "Could not parse longitude to a Double"
            )
            throw DecodingError.dataCorrupted(context)
        }

        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let latitudeString = String(latitude)
        let longitudeString = String(longitude)
        try container.encode(latitudeString, forKey: .latitude)
        try container.encode(longitudeString, forKey: .longitude)
    }

}
