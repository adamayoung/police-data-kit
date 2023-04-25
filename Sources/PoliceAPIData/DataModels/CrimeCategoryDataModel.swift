import Foundation

/// A crime category.
struct CrimeCategoryDataModel: Identifiable, Decodable, Equatable {

    /// Default crime category.
    static let defaultID = "all-crimes"

    /// Unique identifier.
    let id: String
    /// Name of the crime category.
    let name: String

    /// Creates a new `CrimeCategory`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier.
    ///   - name: Name of the crime category.
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension CrimeCategoryDataModel {

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }

}
