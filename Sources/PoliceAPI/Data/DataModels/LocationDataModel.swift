import Foundation

/// A crime's location.
struct LocationDataModel: Decodable, Equatable {

    /// An approximate street for the location.
    ///
    /// This is only an approximation of where the crime happened.
    let street: Street

    /// Location coordinate.
    var coordinate: CoordinateDataModel {
        let lat = Double(latitude) ?? 0
        let long = Double(longitude) ?? 0

        return CoordinateDataModel(latitude: lat, longitude: long)
    }

    private let latitude: String
    private let longitude: String

    /// Creates a new `Location`.
    ///
    /// - Parameters:
    ///   - street: An approximate street for the location.
    ///   - coordinate: Location coordinate.
    init(street: Street, coordinate: CoordinateDataModel) {
        self.street = street
        self.latitude = String(coordinate.latitude)
        self.longitude = String(coordinate.longitude)
    }

}

extension LocationDataModel {

    /// A street for a location.
    struct Street: Identifiable, Decodable, Equatable, CustomStringConvertible {

        /// Unique identifier for the street.
        let id: Int
        /// Name of the location.
        let name: String

        /// Creates a new `Street`.
        ///
        /// - Parameters:
        ///   - id: Unique identifier for the street.
        ///   - name: Name of the approximate location.
        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }

        var description: String {
            "(\(id)) \(name)"
        }

    }

}
