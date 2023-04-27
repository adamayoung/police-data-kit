import Foundation

struct StopAndSearchDataModel: Decodable, Equatable {

    let type: StopAndSearchTypeDataModel
    let didInvolvePerson: Bool
    let gender: GenderDataModel?
    let ageRange: String?
    let selfDefinedEthnicity: String?
    let officerDefinedEthnicity: String?
    let legislation: String
    let objectOfSearch: String
    let removalOfMoreThanOuterClothing: Bool?
    let operationName: String?
    let location: LocationDataModel
    let outcome: String?
    let outcomeLinkedToObjectOfSearch: Bool?
    let date: Date

    init(
        type: StopAndSearchTypeDataModel,
        didInvolvePerson: Bool,
        gender: GenderDataModel? = nil,
        ageRange: String? = nil,
        selfDefinedEthnicity: String? = nil,
        officerDefinedEthnicity: String? = nil,
        legislation: String,
        objectOfSearch: String,
        removalOfMoreThanOuterClothing: Bool? = nil,
        operationName: String? = nil,
        location: LocationDataModel,
        outcome: String? = nil,
        outcomeLinkedToObjectOfSearch: Bool? = nil,
        date: Date
    ) {
        self.type = type
        self.didInvolvePerson = didInvolvePerson
        self.gender = gender
        self.ageRange = ageRange
        self.selfDefinedEthnicity = selfDefinedEthnicity
        self.officerDefinedEthnicity = officerDefinedEthnicity
        self.legislation = legislation
        self.objectOfSearch = objectOfSearch
        self.removalOfMoreThanOuterClothing = removalOfMoreThanOuterClothing
        self.operationName = operationName
        self.location = location
        self.outcome = outcome
        self.outcomeLinkedToObjectOfSearch = outcomeLinkedToObjectOfSearch
        self.date = date
    }

}

extension StopAndSearchDataModel {

    private enum CodingKeys: String, CodingKey {
        case type
        case didInvolvePerson = "involvedPerson"
        case gender
        case ageRange
        case selfDefinedEthnicity
        case officerDefinedEthnicity
        case legislation
        case objectOfSearch
        case removalOfMoreThanOuterClothing
        case operationName
        case location
        case outcome
        case outcomeLinkedToObjectOfSearch
        case date = "datetime"
    }

}
