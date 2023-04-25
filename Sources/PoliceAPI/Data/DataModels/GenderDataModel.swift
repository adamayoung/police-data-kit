import Foundation

/// The gender of a person.
enum GenderDataModel: String, Decodable, CaseIterable, CustomStringConvertible {

    /// Male.
    case male = "Male"
    /// Female.
    case female = "Female"

    var description: String {
        rawValue
    }

}
