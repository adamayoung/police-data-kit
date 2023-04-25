import Foundation
import PoliceAPIDomain

extension CaseHistoryCrime {

    init(dataModel: CaseHistoryCrimeDataModel) {
        let location: Location? = {
            guard let location = dataModel.location else {
                return nil
            }

            return Location(dataModel: location)
        }()

        let locationType: CrimeLocationType? = {
            guard let locationType = dataModel.locationType else {
                return nil
            }

            return CrimeLocationType(dataModel: locationType)
        }()

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
