import Foundation

struct CaseHistoryDataModel: Decodable, Equatable {

    let crime: CaseHistoryCrimeDataModel
    let outcomes: [CaseHistoryOutcomeDataModel]

    init(crime: CaseHistoryCrimeDataModel, outcomes: [CaseHistoryOutcomeDataModel]) {
        self.crime = crime
        self.outcomes = outcomes
    }

}
