import Foundation

/// Crime for a case history.
struct CaseHistoryCrimeDataModel: Decodable, Equatable {

    /// Identifier of the crime.
    ///
    /// This ID only relates to the API, it is NOT a police identifier.
    let id: Int
    /// 64-character unique identifier for the crime.
    ///
    /// This is different to the existing 'id' attribute, which is not guaranteed to always stay the same for each crime.
    let crimeID: String
    /// Extra information about the crime.
    let context: String?
    /// Crime category identifier.
    let categoryID: String
    /// Approximate location of the incident.
    ///
    /// The latitude and longitude locations of Crime and ASB incidents published always represent the approximate location of a crime — not the exact place that it happened. [Police API | Location Anonymisation](https://data.police.uk/about/#location-anonymisation)
    let location: LocationDataModel?
    /// The type of the location.
    let locationType: CrimeLocationTypeDataModel?
    /// For Bristish Transport Police locations, the type of location at which this crime was recorded.
    let locationSubtype: String?
    /// Date (truncated to the year and month) of the crime.
    let date: Date

    /// Creates a new `CaseHistoryCrime`.
    ///
    /// - Parameters:
    ///   - id: Identifier of the crime.
    ///   - crimeID: 64-character unique identifier for the crime.
    ///   - context: Extra information about the crime.
    ///   - categoryID: Crime category identifier.
    ///   - location: Approximate location of the incident.
    ///   - locationType: The type of the location
    ///   - locationSubtype: For Bristish Transport Police locations, the type of location at which this crime was recorded.
    ///   - date: Date of the crime.
    init(
        id: Int,
        crimeID: String,
        context: String? = nil,
        categoryID: String,
        location: LocationDataModel? = nil,
        locationType: CrimeLocationTypeDataModel? = nil,
        locationSubtype: String? = nil,
        date: Date
    ) {
        self.id = id
        self.crimeID = crimeID
        self.context = context
        self.categoryID = categoryID
        self.location = location
        self.locationType = locationType
        self.locationSubtype = locationSubtype
        self.date = date
    }

}

extension CaseHistoryCrimeDataModel {

    private enum CodingKeys: String, CodingKey {
        case id
        case crimeID = "persistentId"
        case context
        case categoryID = "category"
        case location
        case locationType
        case locationSubtype
        case date = "month"
    }

}
