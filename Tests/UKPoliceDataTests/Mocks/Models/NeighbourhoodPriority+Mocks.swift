import Foundation
@testable import UKPoliceData

extension NeighbourhoodPriority {

    static var mock: NeighbourhoodPriority {
        NeighbourhoodPriority(
            issue: "<p>To reduce street drinking and drug use in and around Museum Square, Leicester.</p>",
            issueDate: DateFormatter.policeDataAPI.date(from: "2015-10-08T00:00:00")!,
            action: "<p>Following the closure of a property on West Street, the number of incidents of Anti-Social "
                + "behaviour reported to the Leicestershire Police has dramatically reduced; we are therefore closing "
                + "this priority. Local residents and businesses have been informed of this decision. The local "
                + "Dedicated Neighbourhood team will remain vigilant and will re-evaluate the problem should it "
                + "return.</p>",
            actionDate: DateFormatter.policeDataAPI.date(from: "2015-12-22T00:00:00")
        )
    }

    static var mockNoAction: NeighbourhoodPriority {
        NeighbourhoodPriority(
            issue: "<p>To reduce the amount of Anti-Social Behaviour Humberstone Gate, Leicester.</p>",
            issueDate: DateFormatter.policeDataAPI.date(from: "2016-04-14T00:00:00")!
        )
    }

    static var mocks: [NeighbourhoodPriority] {
        [
            .mock,
            .mockNoAction
        ]
    }

}
