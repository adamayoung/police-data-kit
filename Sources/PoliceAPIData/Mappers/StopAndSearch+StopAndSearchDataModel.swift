import Foundation
import PoliceAPIDomain

extension StopAndSearch {

    init(dataModel: StopAndSearchDataModel) {
        let type = StopAndSearchType(dataModel: dataModel.type)
        let gender: Gender? = {
            guard let gender = dataModel.gender else {
                return nil
            }

            return Gender(dataModel: gender)
        }()
        let location = Location(dataModel: dataModel.location)

        self.init(
            type: type,
            didInvolvePerson: dataModel.didInvolvePerson,
            gender: gender,
            ageRange: dataModel.ageRange,
            selfDefinedEthnicity: dataModel.selfDefinedEthnicity,
            officerDefinedEthnicity: dataModel.officerDefinedEthnicity,
            legislation: dataModel.legislation,
            objectOfSearch: dataModel.objectOfSearch,
            removalOfMoreThanOuterClothing: dataModel.removalOfMoreThanOuterClothing,
            operationName: dataModel.operationName,
            location: location,
            outcome: dataModel.outcome,
            outcomeLinkedToObjectOfSearch: dataModel.outcomeLinkedToObjectOfSearch,
            date: dataModel.date
        )
    }

}
