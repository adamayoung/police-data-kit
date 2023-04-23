import Foundation

/// The gender of a person.
public enum Gender: String, Decodable, CaseIterable, CustomStringConvertible {

    /// Male.
    case male = "Male"
    /// Female.
    case female = "Female"

    public var description: String {
        rawValue
    }

}
