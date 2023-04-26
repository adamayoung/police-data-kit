import Foundation

/// A neighbourhood location.
struct NeighbourhoodLocationDataModel: Decodable, Equatable {

    /// Name.
    let name: String?
    /// Type of location.
    ///
    /// e.g. 'station' (police station)
    let type: String?
    /// Description.
    let description: String?
    /// Location address.
    let address: String
    /// Postcode
    let postcode: String?
    /// Location coordinate.
    var coordinate: CoordinateDataModel? {
        guard let lat = latitude, let long = longitude else {
            return nil
        }

        let latitude = Double(lat) ?? 0
        let longitude = Double(long) ?? 0

        return CoordinateDataModel(latitude: latitude, longitude: longitude)
    }

    private let latitude: String?
    private let longitude: String?

    /// Creates a new `NeighbourhoodLocation`.
    ///
    /// - Parameters:
    ///   - name: Name.
    ///   - type: Type of location.
    ///   - description: Description.
    ///   - address: Location address.
    ///   - postcode: Postcode
    ///   - latitiude: Location coordinate latitude.
    ///   - longitude: Location coordinate longitude.
    init(
        name: String? = nil,
        type: String? = nil,
        description: String? = nil,
        address: String,
        postcode: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.name = name
        self.type = type
        self.description = description
        self.address = address
        self.postcode = postcode
        self.latitude = {
            guard let latitude = latitude else {
                return nil
            }

            return String(latitude)
        }()
        self.longitude = {
            guard let longitude = longitude else {
                return nil
            }

            return String(longitude)
        }()
    }

}
