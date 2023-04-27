import Foundation

struct NeighbourhoodPriorityDataModel: Decodable, Equatable {

    let issue: String
    let issueDate: Date
    var action: String?
    let actionDate: Date?

    init(
        issue: String,
        issueDate: Date,
        action: String? = nil,
        actionDate: Date? = nil
    ) {
        self.issue = issue
        self.issueDate = issueDate
        self.action = action
        self.actionDate = actionDate
    }

}

extension NeighbourhoodPriorityDataModel {

    private enum CodingKeys: String, CodingKey {
        case issue
        case issueDate = "issue-date"
        case action
        case actionDate = "action-date"
    }

}
