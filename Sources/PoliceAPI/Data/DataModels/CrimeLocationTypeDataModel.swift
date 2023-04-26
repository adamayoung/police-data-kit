import Foundation

/// The type of the location of a crime.
enum CrimeLocationTypeDataModel: String, Decodable, CaseIterable, CustomStringConvertible {

    /// A normal police force location.
    case force = "Force"

    /// British Transport Police location.
    ///
    /// British Transport Police locations fall within normal police force boundaries.
    case btp = "BTP"

    var description: String {
        switch self {
        case .force:
            return "Police Force"

        case .btp:
            return "British Transport Police"
        }
    }

}
