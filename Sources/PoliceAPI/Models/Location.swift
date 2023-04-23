import Foundation

/// A crime's location.
public struct Location: Decodable, Equatable {

    /// An approximate street for the location.
    ///
    /// - Note: This is only an approximation of where the crime happened.
    public let street: Street

    /// Location coordinate.
    public var coordinate: Coordinate {
        let lat = Double(latitude) ?? 0
        let long = Double(longitude) ?? 0

        return Coordinate(latitude: lat, longitude: long)
    }

    private let latitude: String
    private let longitude: String

    /// Creates a new `Location`.
    ///
    /// - Parameters:
    ///   - street: An approximate street for the location.
    ///   - coordinate: Location coordinate.
    public init(street: Street, coordinate: Coordinate) {
        self.street = street
        self.latitude = String(coordinate.latitude)
        self.longitude = String(coordinate.longitude)
    }

}

extension Location {

    /// A street for a location.
    public struct Street: Identifiable, Decodable, Equatable, CustomStringConvertible {

        /// Unique identifier for the street.
        public let id: Int
        /// Name of the location.
        public let name: String

        /// Creates a new `Street`.
        ///
        /// - Parameters:
        ///   - id: Unique identifier for the street.
        ///   - name: Name of the approximate location.
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }

        public var description: String {
            "(\(id)) \(name)"
        }

    }

}
