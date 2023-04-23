import Foundation

struct OutcomesForCrimeCachingKey: CachingKey {

    let crimeID: String

    var keyValue: String {
        "outcomes-for-crime-\(crimeID)"
    }

    init(crimeID: String) {
        self.crimeID = crimeID
    }

}
