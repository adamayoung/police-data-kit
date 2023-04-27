import Foundation

struct PoliceOfficerDataModel: Decodable, Equatable {

    let name: String
    let rank: String
    let bio: String?
    let contactDetails: ContactDetailsDataModel

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
