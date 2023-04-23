import Foundation

struct StopAndSearchesForPoliceForceCachingKey: CachingKey {

    let policeForceID: String
    let date: Date

    var keyValue: String {
        "stop-and-searches-for-police-force-\(policeForceID)-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(policeForceID: String, date: Date) {
        self.policeForceID = policeForceID
        self.date = date
    }

}
