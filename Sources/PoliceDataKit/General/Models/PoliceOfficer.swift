import Foundation

///
/// A model representing a police officer.
///
public struct PoliceOfficer: Equatable, Codable {

    /// Name of the person.
    public let name: String

    /// Police Force rank.
    public let rank: String?

    /// Officer biography.
    public let bio: String?

    /// Contact details for the Officer.
    public let contactDetails: ContactDetails

    ///
    /// Creates a police office object.
    ///
    /// - Parameters:
    ///   - name: Name of the person.
    ///   - rank: Police Force rank.
    ///   - bio: Officer biography.
    ///   - contactDetails: Contact details for the Officer.
    ///
    public init(
        name: String,
        rank: String? = nil,
        bio: String? = nil,
        contactDetails: ContactDetails
    ) {
        self.name = name
        self.rank = rank
        self.bio = bio
        self.contactDetails = contactDetails
    }

}
