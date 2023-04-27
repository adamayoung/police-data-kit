import Foundation

struct CaseHistoryOutcomeDataModel: Decodable, Equatable {

    let personID: String?
    let date: Date
    let category: OutcomeCategoryDataModel

    init(personID: String? = nil, date: Date, category: OutcomeCategoryDataModel) {
        self.personID = personID
        self.date = date
        self.category = category
    }

}

extension CaseHistoryOutcomeDataModel {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
    }

}
