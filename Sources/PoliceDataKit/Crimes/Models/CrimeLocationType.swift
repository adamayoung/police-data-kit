import Foundation

///
/// The location type of a crime.
///
public enum CrimeLocationType: String, Equatable, CaseIterable, CustomStringConvertible, Codable {

    /// A normal police force location.
    case force = "Force"

    /// British Transport Police location.
    ///
    /// British Transport Police locations fall within normal police force boundaries.
    case britishTransportPolice = "BTP"

    /// The localized string describing the crime location type.
    public var description: String {
        switch self {
        case .force:
            return NSLocalizedString("POLICE_FORCE", bundle: .module, comment: "Police Force")

        case .britishTransportPolice:
            return NSLocalizedString("BRITISH_TRANSPORT_POLICE", bundle: .module, comment: "British Transport Police")
        }
    }

}
