import Foundation

///
/// The location type of a crime.
///
public enum CrimeLocationType: Equatable, CaseIterable {

    /// A normal police force location.
    case force

    /// British Transport Police location.
    ///
    /// British Transport Police locations fall within normal police force boundaries.
    case britishTransportPolice

    /// A localized name describing the crime location type.
    public var localizedName: String {
        switch self {
        case .force:
            return NSLocalizedString("POLICE_FORCE", bundle: .module, comment: "Police Force")

        case .britishTransportPolice:
            return NSLocalizedString("BRITISH_TRANSPORT_POLICE", bundle: .module, comment: "British Transport Police")
        }
    }

}
