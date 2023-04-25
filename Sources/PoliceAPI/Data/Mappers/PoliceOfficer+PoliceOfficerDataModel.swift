import Foundation

extension PoliceOfficer {

    init(dataModel: PoliceOfficerDataModel) {
        let contactDetails = ContactDetails(dataModel: dataModel.contactDetails)

        self.init(
            name: dataModel.name,
            rank: dataModel.rank,
            bio: dataModel.bio,
            contactDetails: contactDetails
        )
    }

}
