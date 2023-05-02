import Foundation

///
/// The gender of a person.
///
public enum Gender: Equatable, CaseIterable {

    /// Male.
    case male

    /// Female.
    case female

    /// A localized name describing the gender.
    public var localizedName: String {
        switch self {
        case .male:
            return NSLocalizedString("MALE", bundle: .module, comment: "Male")

        case .female:
            return NSLocalizedString("FEMALE", bundle: .module, comment: "Female")
        }
    }

}
