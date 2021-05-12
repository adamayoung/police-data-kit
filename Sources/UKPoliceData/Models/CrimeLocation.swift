import Foundation

public struct CrimeLocation: Decodable, Equatable {

    /// The approximate street the crime occurred.
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

    public init(street: Street, latitude: Double, longitude: Double) {
        self.street = street
        self.latitude = String(latitude)
        self.longitude = String(longitude)
    }

}

extension CrimeLocation {

    /// A street where a crime occurred
    public struct Street: Identifiable, Decodable, Equatable, CustomStringConvertible {

        /// Unique identifier for the street.
        public let id: Int
        /// Name of the location.
        public let name: String

        /// Creates a a new `CrimeCategory`.
        ///
        /// - Parameters:
        ///     - id: Unique identifier for the street.
        ///     - name: Name of the approximate location.
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }

        public var description: String {
            "(\(id)) \(name)"
        }

    }

}
