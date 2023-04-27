import Foundation

struct OutcomeStatusDataModel: Decodable, Equatable {

    let category: String
    let date: Date

    init(category: String, date: Date) {
        self.category = category
        self.date = date
    }

}
