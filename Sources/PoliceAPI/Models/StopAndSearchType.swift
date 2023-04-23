import Foundation

/// Type of Stop and Search.
public enum StopAndSearchType: String, Decodable, CaseIterable, CustomStringConvertible {

    /// Person search.
    case personSearch = "Person search"
    /// Vehicle search.
    case vehicleSearch = "Vehicle search"
    /// Person and vehicle search.
    case personAndVehicleSearch = "Person and Vehicle search"

    public var description: String {
        rawValue
    }

}
