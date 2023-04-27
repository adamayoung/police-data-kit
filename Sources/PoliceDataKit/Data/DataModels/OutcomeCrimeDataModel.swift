import Foundation

struct OutcomeCrimeDataModel: Identifiable, Decodable, Equatable {

    let id: Int
    let crimeID: String
    let context: String?
    let categoryID: String
    let location: LocationDataModel
    let locationType: CrimeLocationTypeDataModel
    let locationSubtype: String?
    let date: Date

    init(
        id: Int,
        crimeID: String,
        context: String? = nil,
        categoryID: String,
        location: LocationDataModel,
        locationType: CrimeLocationTypeDataModel,
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

extension OutcomeCrimeDataModel {

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
