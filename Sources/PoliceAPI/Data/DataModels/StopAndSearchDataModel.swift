import Foundation

/// A Stop and Search.
struct StopAndSearchDataModel: Decodable, Equatable {

    /// Type of stop and search.
    let type: StopAndSearchTypeDataModel
    /// Whether a person was searched in this incident.
    let didInvolvePerson: Bool
    /// Gender of person stropped, if applicable and provided.
    let gender: GenderDataModel?
    /// The age range of the person stopped at the time the stop occurred.
    let ageRange: String?
    /// The self-defined ethnicity of the person stopped.
    let selfDefinedEthnicity: String?
    /// The officer-defined ethnicity of the person stopped.
    let officerDefinedEthnicity: String?
    /// The power used to carry out the stop and search.
    let legislation: String
    /// The reason the stop and search was carried out.
    let objectOfSearch: String
    /// Whether the person searched had more than their outer clothing removed
    let removalOfMoreThanOuterClothing: Bool?
    /// The name of the operation this stop and search was part of.
    let operationName: String?
    /// Approximate location of the incident.
    let location: LocationDataModel
    /// The outcome of the stop.
    let outcome: String?
    /// Whether the outcome was related to the reason the stop and search was carried out.
    let outcomeLinkedToObjectOfSearch: Bool?
    /// When the stop and search took place.
    ///
    /// Some forces only provide dates for their stop and searches, so you might see a disproportionate number of incidents occuring at midnight.
    let date: Date

    /// Creates a new `StopAndSearch`.
    ///
    /// - Parameters:
    ///   - type: Type of stop and search.
    ///   - didInvolvePerson: Whether a person was searched in this incident.
    ///   - gender: Gender of person stropped, if applicable and provided.
    ///   - ageRange: The age range of the person stopped at the time the stop occurred.
    ///   - selfDefinedEthnicity: The self-defined ethnicity of the person stopped.
    ///   - officerDefinedEthnicity: The officer-defined ethnicity of the person stopped.
    ///   - legislation: The power used to carry out the stop and search.
    ///   - objectOfSearch: The reason the stop and search was carried out.
    ///   - removalOfMoreThanOuterClothing: Whether the person searched had more than their outer clothing removed
    ///   - operationName: The name of the operation this stop and search was part of.
    ///   - location: Approximate location of the incident.
    ///   - outcome: The outcome of the stop.
    ///   - outcomeLinkedToObjectOfSearch: When the stop and search took place.
    ///   - date: When the stop and search took place.
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
