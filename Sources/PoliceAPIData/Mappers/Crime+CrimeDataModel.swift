import Foundation
import PoliceAPIDomain

extension Crime {

    init(dataModel: CrimeDataModel) {
        let location = Location(dataModel: dataModel.location)
        let locationType = CrimeLocationType(dataModel: dataModel.locationType)
        let outcomeStatus: OutcomeStatus? = {
            guard let outcomeStatus = dataModel.outcomeStatus else {
                return nil
            }

            return OutcomeStatus(dataModel: outcomeStatus)
        }()

        self.init(
            id: dataModel.id,
            crimeID: dataModel.crimeID,
            context: dataModel.context,
            categoryID: dataModel.categoryID,
            location: location,
            locationType: locationType,
            locationSubtype: dataModel.locationSubtype,
            date: dataModel.date,
            outcomeStatus: outcomeStatus
        )
    }

}
