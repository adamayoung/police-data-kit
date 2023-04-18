import Foundation

/// A Police Force.
public struct PoliceForce: Identifiable, Decodable, Equatable {

    /// Unique Police Force identifier.
    public let id: String
    /// Police Force name.
    public let name: String
    /// Description.
    public let description: String?
    /// Telephone number.
    public let telephone: String
    /// Police Force website URL.
    public let url: URL
    /// Engagement methods - Ways to keep informed.
    public let engagementMethods: [EngagementMethod]

    /// Creates a a new `PoliceForce`.
    ///
    /// - Parameters:
    ///     - id: Unique force identifier.
    ///     - name: Force name.
    ///     - description: Description.
    ///     - telephone: Telephone number.
    ///     - url: Police Force website URL.
    ///     - engagementMethods: Engagement methods - Ways to keep informed.
    public init(id: String, name: String, description: String? = nil, telephone: String, url: URL,
                engagementMethods: [EngagementMethod] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.telephone = telephone
        self.url = url
        self.engagementMethods = engagementMethods
    }

}
