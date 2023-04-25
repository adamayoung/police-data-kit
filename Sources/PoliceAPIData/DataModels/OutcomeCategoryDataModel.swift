import Foundation

/// Category of the outcome of a crime.
struct OutcomeCategoryDataModel: Identifiable, Decodable, Equatable {

    /// Category code.
    let id: String

    /// Name of the category.
    let name: String

    /// Creates a new `OutcomeCategory`.
    ///
    /// - Parameters:
    ///   - id: Category code.
    ///   - name: Name of the category.
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension OutcomeCategoryDataModel {

    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case name
    }

}
