import Foundation

/// The gender of a person.
public enum Gender: CaseIterable, CustomStringConvertible {

    /// Male.
    case male
    /// Female.
    case female

    public var description: String {
        switch self {
        case .male:
            return "Male"

        case .female:
            return "Female"
        }
    }

}
