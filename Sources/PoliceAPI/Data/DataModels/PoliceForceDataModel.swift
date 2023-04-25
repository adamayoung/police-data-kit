import Foundation

/// A Police Force.
struct PoliceForceDataModel: Identifiable, Decodable, Equatable {

    /// Unique Police Force identifier.
    let id: String
    /// Police Force name.
    let name: String
    /// Description.
    let description: String?
    /// Telephone number.
    let telephone: String
    /// Police Force website URL.
    let url: URL
    /// Engagement methods - Ways to keep informed.
    let engagementMethods: [EngagementMethodDataModel]

    /// Creates a new `PoliceForce`.
    ///
    /// - Parameters:
    ///   - id: Unique force identifier.
    ///   - name: Force name.
    ///   - description: Description.
    ///   - telephone: Telephone number.
    ///   - url: Police Force website URL.
    ///   - engagementMethods: Engagement methods - Ways to keep informed.
    init(
        id: String,
        name: String,
        description: String? = nil,
        telephone: String,
        url: URL,
        engagementMethods: [EngagementMethodDataModel] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.telephone = telephone
        self.url = url
        self.engagementMethods = engagementMethods
    }

}
