import Foundation

/// Type of Stop and Search.
enum StopAndSearchTypeDataModel: String, Decodable, CaseIterable, CustomStringConvertible {

    /// Person search.
    case personSearch = "Person search"
    /// Vehicle search.
    case vehicleSearch = "Vehicle search"
    /// Person and vehicle search.
    case personAndVehicleSearch = "Person and Vehicle search"

    var description: String {
        rawValue
    }

}
