import Foundation

struct CrimesWithNoLocationForCategoryInPoliceForceCachingKey: CachingKey {

    let categoryID: CrimeCategoryDataModel.ID
    let policeForceID: PoliceForceDataModel.ID
    let date: Date

    var keyValue: String {
        "crimes-with-no-location-in-category-\(categoryID)-police-force-\(policeForceID)-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(categoryID: CrimeCategoryDataModel.ID, policeForceID: PoliceForceDataModel.ID, date: Date) {
        self.categoryID = categoryID
        self.policeForceID = policeForceID
        self.date = date
    }

}
