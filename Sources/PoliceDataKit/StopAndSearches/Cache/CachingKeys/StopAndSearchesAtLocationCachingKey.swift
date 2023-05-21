import Foundation

struct StopAndSearchesAtLocationCachingKey: CachingKey {

    let streetID: Int
    let date: Date

    var keyValue: String {
        "stop-and-searches-at-location-\(streetID)-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(streetID: Int, date: Date) {
        self.streetID = streetID
        self.date = date
    }

}
