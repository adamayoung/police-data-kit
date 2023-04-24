import Foundation

struct CrimeCategoriesCachingKey: CachingKey {

    let date: Date

    var keyValue: String {
        "crime-categories-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(date: Date) {
        self.date = date
    }

}
