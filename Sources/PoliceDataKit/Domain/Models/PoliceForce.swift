import Foundation

///
/// A model representing a police force.
///
public struct PoliceForce: Identifiable, Equatable {

    /// Unique police force identifier.
    public let id: String

    /// Police force name.
    public let name: String

    /// Description.
    public let description: String?

    /// Telephone number.
    public let telephone: String

    /// Police force website URL.
    public let url: URL

    /// Engagement methods - Ways to keep informed.
    public let engagementMethods: [EngagementMethod]

    ///
    /// Creates a police force object.
    ///
    /// - Parameters:
    ///   - id: Unique force identifier.
    ///   - name: Force name.
    ///   - description: Description.
    ///   - telephone: Telephone number.
    ///   - url: Police Force website URL.
    ///   - engagementMethods: Engagement methods - Ways to keep informed.
    /// 
    public init(
        id: String,
        name: String,
        description: String? = nil,
        telephone: String,
        url: URL,
        engagementMethods: [EngagementMethod] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.telephone = telephone
        self.url = url
        self.engagementMethods = engagementMethods
    }

}
