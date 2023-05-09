import Foundation

///
/// A model representing a category of a crime.
///
public struct CrimeCategory: Identifiable, Decodable, Equatable {

    /// The default crime category which includes all crimes.
    public static let `default` = CrimeCategory(
        id: "all-crime",
        name: "All Crimes"
    )

    /// Identifier of a crime category.
    public let id: String

    /// Name of the crime category.
    public let name: String

    /// Creates a crime category object.
    ///
    /// - Parameters:
    ///   - id: Identifier of a crime category.
    ///   - name: Name of the crime category.
    ///
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension CrimeCategory {

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }

}
