import Foundation
@testable import PoliceAPI

extension EngagementMethodDataModel {

    static var mock: EngagementMethodDataModel {
        EngagementMethodDataModel(
            title: "Facebook",
            description: "Become friends with Leicestershire Constabulary",
            url: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169"
        )
    }

    static var mockNoURL: EngagementMethodDataModel {
        EngagementMethodDataModel(
            title: "telephone",
            description: "101"
        )
    }

}
