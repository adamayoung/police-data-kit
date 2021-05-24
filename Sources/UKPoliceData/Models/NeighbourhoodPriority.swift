import Foundation

/// A Neighbourhood Priority.
public struct NeighbourhoodPriority: Decodable, Equatable {

    /// An issue raised with the police.
    public var issue: String {
        issueString.htmlStripped
    }
    /// When the priority was agreed upon.
    public let issueDate: Date
    /// Action taken to address the priority.
    public var action: String? {
        actionString?.htmlStripped
    }
    /// When action was last taken.
    public let actionDate: Date?

    private let issueString: String
    private let actionString: String?

    /// Creates a a new `NeighbourhoodPriority`.
    ///
    /// - Parameters:
    ///     - issue: An issue raised with the police.
    ///     - issueDate: When the priority was agreed upon.
    ///     - action: Action taken to address the priority.
    ///     - actionDate: When action was last taken.
    public init(issue: String, issueDate: Date, action: String? = nil, actionDate: Date? = nil) {
        self.issueString = issue
        self.issueDate = issueDate
        self.actionString = action
        self.actionDate = actionDate
    }

}

extension NeighbourhoodPriority {

    private enum CodingKeys: String, CodingKey {
        case issueString = "issue"
        case issueDate = "issue-date"
        case actionString = "action"
        case actionDate = "action-date"
    }

}
