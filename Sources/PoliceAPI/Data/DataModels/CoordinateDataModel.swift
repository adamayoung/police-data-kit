import Foundation

/// Coordinate.
struct CoordinateDataModel: Decodable, Equatable, CustomStringConvertible {

    /// Latitude.
    var latitude: Double
    /// Longitude.
    var longitude: Double

    /// Creates a new `Coordinate`.
    ///
    /// - Parameters:
    ///   - latitude: Latitude.
    ///   - longitude: Longitude.
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var description: String {
        "(\(latitude), \(longitude))"
    }

}

extension CoordinateDataModel {

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitudeString = try container.decodeIfPresent(String.self, forKey: .latitude)
        let longitudeString = try container.decodeIfPresent(String.self, forKey: .longitude)

        guard
            let latitude = Double(latitudeString ?? ""),
            let longitude = Double(longitudeString ?? "")
        else {
            self.latitude = 0
            self.longitude = 0
            return
        }

        self.latitude = latitude
        self.longitude = longitude
    }

}