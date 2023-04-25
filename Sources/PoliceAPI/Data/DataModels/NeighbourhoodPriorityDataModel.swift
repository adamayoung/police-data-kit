import Foundation

/// A Neighbourhood Priority.
struct NeighbourhoodPriorityDataModel: Decodable, Equatable {

    /// An issue raised with the police.
    let issue: String
    /// When the priority was agreed upon.
    let issueDate: Date
    /// Action taken to address the priority.
    var action: String?
    /// When action was last taken.
    let actionDate: Date?

    /// Creates a new `NeighbourhoodPriority`.
    ///
    /// - Parameters:
    ///   - issue: An issue raised with the police.
    ///   - issueDate: When the priority was agreed upon.
    ///   - action: Action taken to address the priority.
    ///   - actionDate: When action was last taken.
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
