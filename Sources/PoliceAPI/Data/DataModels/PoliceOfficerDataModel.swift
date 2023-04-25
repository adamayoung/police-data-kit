import Foundation

/// A Police Officer.
struct PoliceOfficerDataModel: Decodable, Equatable {

    /// Name of the person.
    let name: String
    /// Police Force rank.
    let rank: String
    /// Officer biography.
    let bio: String?
    /// Contact details for the Officer.
    let contactDetails: ContactDetailsDataModel

    /// Creates a new `ContactDetails`.
    ///
    /// - Parameters:
    ///   - name: Name of the person.
    ///   - rank: Police Force rank.
    ///   - bio: Officer biography.
    ///   - contactDetails: Contact details for the Officer.
    init(
        name: String,
        rank: String,
        bio: String? = nil,
        contactDetails: ContactDetailsDataModel
    ) {
        self.name = name
        self.rank = rank
        self.bio = bio
        self.contactDetails = contactDetails
    }

}
