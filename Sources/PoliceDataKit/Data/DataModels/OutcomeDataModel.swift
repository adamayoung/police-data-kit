import Foundation

struct OutcomeDataModel: Decodable, Equatable {

    let personID: String?
    let date: Date
    let category: OutcomeCategoryDataModel
    let crime: OutcomeCrimeDataModel

    init(
        personID: String? = nil,
        date: Date,
        category: OutcomeCategoryDataModel,
        crime: OutcomeCrimeDataModel
    ) {
        self.personID = personID
        self.date = date
        self.category = category
        self.crime = crime
    }

}

extension OutcomeDataModel {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
        case crime
    }

}
