//
//  NeighbourhoodPriority.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

///
/// A model representing a neighbourhood priority.
///
public struct NeighbourhoodPriority: Equatable, Codable {

    /// An issue raised with the police.
    public let issue: String

    /// When the priority was agreed upon.
    public let issueDate: Date

    /// Action taken to address the priority.
    public let action: String?

    /// When action was last taken.
    public let actionDate: Date?

    ///
    /// Creates a neighbourhood priority object.
    ///
    /// - Parameters:
    ///   - issue: An issue raised with the police.
    ///   - issueDate: When the priority was agreed upon.
    ///   - action: Action taken to address the priority.
    ///   - actionDate: When action was last taken.
    ///
    public init(
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

extension NeighbourhoodPriority {

    private enum CodingKeys: String, CodingKey {
        case issue
        case issueDate = "issue-date"
        case action
        case actionDate = "action-date"
    }

}
