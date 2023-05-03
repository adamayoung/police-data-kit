import Foundation
@testable import PoliceDataKit

extension Link {

    static var mock: Self {
        Link(
            title: "Leicester City Council",
            description: "Leicester City Council description",
            url: URL(string: "http://www.leicester.gov.uk/")
        )
    }

    static var mockNoDescription: Self {
        Link(
            title: "Leicester City Council",
            url: URL(string: "http://www.leicester.gov.uk/")
        )
    }

    static var mockNilURL: Self {
        Link(
            title: "YourCommunityAlerts.co.uk",
            description: "Your Community Alerts",
            url: nil
        )
    }

}
