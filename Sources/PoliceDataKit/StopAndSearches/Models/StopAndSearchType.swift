import Foundation

///
/// The type of a stop and search.
///
public enum StopAndSearchType: String, Equatable, CaseIterable, Codable {

    /// Person search.
    case personSearch = "Person search"

    /// Vehicle search.
    case vehicleSearch = "Vehicle search"

    /// Person and vehicle search.
    case personAndVehicleSearch = "Person and Vehicle search"

    /// A localized name describing the stop and search.
    public var localizedName: String {
        switch self {
        case .personSearch:
            return NSLocalizedString("PERSON_SEARCH", bundle: .module, comment: "Person search")

        case .vehicleSearch:
            return NSLocalizedString("VEHICLE_SEARCH", bundle: .module, comment: "Vehicle search")

        case .personAndVehicleSearch:
            return NSLocalizedString("PERSON_AND_VEHICLE_SEARCH", bundle: .module, comment: "Person and Vehicle search")
        }
    }

}
