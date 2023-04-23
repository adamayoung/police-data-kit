import Foundation

/// A Stop and Search.
public struct StopAndSearch: Decodable, Equatable {

    /// Type of stop and search.
    public let type: StopAndSearchType
    /// Whether a person was searched in this incident.
    public let didInvolvePerson: Bool
    /// Gender of person stropped, if applicable and provided.
    public let gender: Gender?
    /// The age range of the person stopped at the time the stop occurred.
    public let ageRange: String?
    /// The self-defined ethnicity of the person stopped.
    public let selfDefinedEthnicity: String?
    /// The officer-defined ethnicity of the person stopped.
    public let officerDefinedEthnicity: String?
    /// The power used to carry out the stop and search.
    public let legislation: String
    /// The reason the stop and search was carried out.
    public let objectOfSearch: String
    /// Whether the person searched had more than their outer clothing removed
    public let removalOfMoreThanOuterClothing: Bool?
    /// The name of the operation this stop and search was part of.
    public let operationName: String?
    /// Approximate location of the incident.
    public let location: Location
    /// The outcome of the stop.
    public let outcome: String?
    /// Whether the outcome was related to the reason the stop and search was carried out.
    public let outcomeLinkedToObjectOfSearch: Bool?
    /// When the stop and search took place.
    ///
    /// - Note: Some forces only provide dates for their stop and searches, so you might see a disproportionate number of incidents occuring at midnight.
    public let date: Date

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
    public init(
        type: StopAndSearchType,
        didInvolvePerson: Bool,
        gender: Gender? = nil,
        ageRange: String? = nil,
        selfDefinedEthnicity: String? = nil,
        officerDefinedEthnicity: String? = nil,
        legislation: String,
        objectOfSearch: String,
        removalOfMoreThanOuterClothing: Bool? = nil,
        operationName: String? = nil,
        location: Location,
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

extension StopAndSearch {

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
