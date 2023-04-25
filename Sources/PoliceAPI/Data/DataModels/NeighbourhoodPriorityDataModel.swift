import Foundation

/// A Neighbourhood Priority.
struct NeighbourhoodPriorityDataModel: Decodable, Equatable {

    /// An issue raised with the police.
    var issue: String {
        issueString.htmlStripped
    }
    /// When the priority was agreed upon.
    let issueDate: Date
    /// Action taken to address the priority.
    var action: String? {
        actionString?.htmlStripped
    }
    /// When action was last taken.
    let actionDate: Date?

    private let issueString: String
    private let actionString: String?

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
        self.issueString = issue
        self.issueDate = issueDate
        self.actionString = action
        self.actionDate = actionDate
    }

}

extension NeighbourhoodPriorityDataModel {

    private enum CodingKeys: String, CodingKey {
        case issueString = "issue"
        case issueDate = "issue-date"
        case actionString = "action"
        case actionDate = "action-date"
    }

}
