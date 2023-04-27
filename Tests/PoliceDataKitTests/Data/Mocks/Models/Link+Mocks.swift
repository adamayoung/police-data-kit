import Foundation
@testable import PoliceDataKit

extension LinkDataModel {

    static var mock: Self {
        LinkDataModel(
            title: "Leicester City Council",
            description: "Leicester City Council description",
            url: "http://www.leicester.gov.uk/"
        )
    }

    static var mockNoDescription: Self {
        LinkDataModel(
            title: "Leicester City Council",
            url: "http://www.leicester.gov.uk/"
        )
    }

    static var mockNilURL: Self {
        LinkDataModel(
            title: "YourCommunityAlerts.co.uk",
            description: "Your Community Alerts",
            url: nil
        )
    }

}
