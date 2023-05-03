import Foundation

struct PoliceForceSeniorOfficersCachingKey: CachingKey {

    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "police-force-\(policeForceID)-senior-officers"
    }

    init(policeForceID: PoliceForce.ID) {
        self.policeForceID = policeForceID
    }

}
