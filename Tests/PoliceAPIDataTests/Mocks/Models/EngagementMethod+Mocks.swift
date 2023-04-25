import Foundation
@testable import PoliceAPIData

extension EngagementMethodDataModel {

    static var mock: EngagementMethodDataModel {
        EngagementMethodDataModel(
            title: "Facebook",
            description: "Become friends with Leicestershire Constabulary",
            url: URL(string: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169")!
        )
    }

    static var mockNoURL: EngagementMethodDataModel {
        EngagementMethodDataModel(
            title: "telephone",
            description: "101"
        )
    }

}
