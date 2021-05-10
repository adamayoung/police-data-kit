import Foundation

/// The type of the location of a crime.
public enum CrimeLocationType: String, Decodable, CaseIterable {

    /// A normal police force location.
    case force = "Force"
    /// British Transport Police location.
    ///
    /// - Note: British Transport Police locations fall within normal police force boundaries.
    case btp = "BTP"

}

extension CrimeLocationType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .force:
            return "Police Force"

        case .btp:
            return "British Transport Police"
        }
    }

}
