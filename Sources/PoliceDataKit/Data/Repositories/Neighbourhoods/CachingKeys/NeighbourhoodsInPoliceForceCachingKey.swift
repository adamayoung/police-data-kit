import Foundation

struct NeighbourhoodsInPoliceForceCachingKey: CachingKey {

    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "neighbourhoods-in-police-force-\(policeForceID)"
    }

    init(policeForceID: PoliceForceDataModel.ID) {
        self.policeForceID = policeForceID
    }

}
