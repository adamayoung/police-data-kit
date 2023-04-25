import Foundation

/// The type of the location of a crime.
public enum CrimeLocationType: CaseIterable, CustomStringConvertible {

    /// A normal police force location.
    case force

    /// British Transport Police location.
    ///
    /// - Note: British Transport Police locations fall within normal police force boundaries.
    case britishTransportPolice

    public var description: String {
        switch self {
        case .force:
            return "Police Force"

        case .britishTransportPolice:
            return "British Transport Police"
        }
    }

}
