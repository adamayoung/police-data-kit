import Foundation

struct OutcomesAtStreetLevelForStreetCachingKey: CachingKey {

    let streetID: Int
    let date: Date

    var keyValue: String {
        "outcomes-street-level-for-street-\(streetID)-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(streetID: Int, date: Date) {
        self.streetID = streetID
        self.date = date
    }

}
