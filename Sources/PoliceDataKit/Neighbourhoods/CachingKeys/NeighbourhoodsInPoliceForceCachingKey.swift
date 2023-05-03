import Foundation

struct NeighbourhoodsInPoliceForceCachingKey: CachingKey {

    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhoods-in-police-force-\(policeForceID)"
    }

    init(policeForceID: PoliceForce.ID) {
        self.policeForceID = policeForceID
    }

}
