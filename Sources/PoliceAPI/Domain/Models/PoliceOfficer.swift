import Foundation

/// A Police Officer.
public struct PoliceOfficer: Equatable {

    /// Name of the person.
    public let name: String
    /// Police Force rank.
    public let rank: String
    /// Officer biography.
    public let bio: String?
    /// Contact details for the Officer.
    public let contactDetails: ContactDetails

    /// Creates a new `ContactDetails`.
    ///
    /// - Parameters:
    ///   - name: Name of the person.
    ///   - rank: Police Force rank.
    ///   - bio: Officer biography.
    ///   - contactDetails: Contact details for the Officer.
    public init(
        name: String,
        rank: String,
        bio: String? = nil,
        contactDetails: ContactDetails
    ) {
        self.name = name
        self.rank = rank
        self.bio = bio
        self.contactDetails = contactDetails
    }

}
