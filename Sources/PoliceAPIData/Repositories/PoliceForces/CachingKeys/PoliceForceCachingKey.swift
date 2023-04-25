import Foundation

struct PoliceForceCachingKey: CachingKey {

    let id: PoliceForceDataModel.ID

    var keyValue: String {
        "police-force-\(id)"
    }

    init(id: PoliceForceDataModel.ID) {
        self.id = id
    }

}
