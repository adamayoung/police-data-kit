import Foundation

/// A location
public struct Location: Decodable, Equatable {

    /// Name.
    public let name: String?
    /// Type of location.
    ///
    /// - Note: e.g. 'station' (police station)
    public let type: String
    /// Description.
    public let description: String?
    /// Location address.
    public let address: String
    /// Postcode
    public let postcode: String
    /// Location latitude.
    public let latitude: String?
    /// Location longitude.
    public let longitude: String?

    public init(name: String? = nil, type: String, description: String? = nil, address: String, postcode: String,
                latitude: String? = nil, longitude: String? = nil) {
        self.name = name
        self.type = type
        self.description = description
        self.address = address
        self.postcode = postcode
        self.latitude = latitude
        self.longitude = longitude
    }

}
