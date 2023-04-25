import Foundation
import PoliceAPIDomain

extension OutcomeCrime {

    init(dataModel: OutcomeCrimeDataModel) {
        let location = Location(dataModel: dataModel.location)
        let locationType = CrimeLocationType(dataModel: dataModel.locationType)

        self.init(
            id: dataModel.id,
            crimeID: dataModel.crimeID,
            context: dataModel.context,
            categoryID: dataModel.categoryID,
            location: location,
            locationType: locationType,
            locationSubtype: dataModel.locationSubtype,
            date: dataModel.date
        )
    }

}
