import Foundation
@testable import PoliceAPI

extension EngagementMethodDataModel {

    static var mock: Self {
        EngagementMethodDataModel(
            title: "Facebook",
            description: "Become friends with Leicestershire Constabulary",
            url: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169"
        )
    }

    static var mockNoURL: Self {
        EngagementMethodDataModel(
            title: "telephone",
            description: "101"
        )
    }

}
