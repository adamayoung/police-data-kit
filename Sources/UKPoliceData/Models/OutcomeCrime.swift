import Foundation

/// An outcome's crime.
public struct OutcomeCrime: Identifiable, Decodable, Equatable {

    /// Identifier of the crime.
    ///
    /// - Note: This ID only relates to the API, it is NOT a police identifier.
    public let id: Int
    /// 64-character unique identifier for that crime.
    ///
    /// - Note: This is different to the existing 'id' attribute, which is not guaranteed to always stay the same for each crime.
    public let persistentID: String
    /// Extra information about the crime.
    public let context: String?
    /// Crime category identifier.
    public let categoryID: String
    /// Approximate location of the incident.
    ///
    /// - Note: The latitude and longitude locations of Crime and ASB incidents published always represent the approximate location of a crime — not the exact place that it happened. [Police API | Location Anonymisation](https://data.police.uk/about/#location-anonymisation)
    public let location: CrimeLocation
    /// The type of the location.
    public let locationType: CrimeLocationType
    /// For Bristish Transport Police locations, the type of location at which this crime was recorded.
    public let locationSubtype: String?
    /// Month of the crime.
    public let month: String

    /// Creates a a new `OutcomeCrime`.
    ///
    /// - Parameters:
    ///     - id: Identifier of the crime.
    ///     - persistentID: 64-character unique identifier for that crime.
    ///     - context: Extra information about the crime.
    ///     - categoryID: Crime category identifier.
    ///     - location: Approximate location of the incident.
    ///     - locationType: The type of the location.
    ///     - locationSubtype: For Bristish Transport Police locations, the type of location at which this crime was recorded.
    ///     - month: Month of the crime.
    public init(id: Int, persistentID: String, context: String? = nil, categoryID: String, location: CrimeLocation,
                locationType: CrimeLocationType, locationSubtype: String? = nil, month: String) {
        self.id = id
        self.persistentID = persistentID
        self.context = context
        self.categoryID = categoryID
        self.location = location
        self.locationType = locationType
        self.locationSubtype = locationSubtype
        self.month = month
    }

}

extension OutcomeCrime {

    private enum CodingKeys: String, CodingKey {
        case id
        case persistentID = "persistentId"
        case context
        case categoryID = "category"
        case location
        case locationType
        case locationSubtype
        case month
    }

}
