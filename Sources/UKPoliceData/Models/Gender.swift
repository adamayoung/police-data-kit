import Foundation

public enum Gender: String, Decodable, CaseIterable, CustomStringConvertible {

    case male = "Male"
    case female = "Female"

    public var description: String {
        rawValue
    }

}
