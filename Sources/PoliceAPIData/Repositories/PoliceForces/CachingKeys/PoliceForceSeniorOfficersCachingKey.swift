import Foundation

struct PoliceForceSeniorOfficersCachingKey: CachingKey {

    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "police-force-\(policeForceID)-senior-officers"
    }

    init(policeForceID: PoliceForceDataModel.ID) {
        self.policeForceID = policeForceID
    }

}
