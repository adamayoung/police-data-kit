import Foundation

/// Type of Stop and Search.
public enum StopAndSearchType: CaseIterable, CustomStringConvertible {

    /// Person search.
    case personSearch
    /// Vehicle search.
    case vehicleSearch
    /// Person and vehicle search.
    case personAndVehicleSearch

    public var description: String {
        switch self {
        case .personSearch:
            return "Person search"

        case .vehicleSearch:
            return "Vehicle search"

        case .personAndVehicleSearch:
            return "Person and Vehicle search"
        }
    }

}
