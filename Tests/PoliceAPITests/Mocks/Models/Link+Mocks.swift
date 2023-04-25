import Foundation
@testable import PoliceAPI

extension LinkDataModel {

    static var mock: LinkDataModel {
        LinkDataModel(
            title: "Leicester City Council",
            description: "Leicester City Council description",
            url: URL(string: "http://www.leicester.gov.uk/")
        )
    }

    static var mockNoDescription: LinkDataModel {
        LinkDataModel(
            title: "Leicester City Council",
            url: URL(string: "http://www.leicester.gov.uk/")
        )
    }

    static var mockNilURL: LinkDataModel {
        LinkDataModel(
            title: "YourCommunityAlerts.co.uk",
            description: "Your Community Alerts",
            url: nil
        )
    }

}
