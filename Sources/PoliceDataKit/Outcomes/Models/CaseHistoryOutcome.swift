//
//  CaseHistoryOutcome.swift
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
/// A model representing a case history outcome.
///
public struct CaseHistoryOutcome: Equatable, Codable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?

    /// Date (truncated to the year and month) of the crime.
    public let date: Date

    /// Category of the outcome.
    public let category: OutcomeCategory

    ///
    /// Creates a case history outcome object.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Month of the crime.
    ///   - category: Category of the outcome.
    ///
    public init(personID: String? = nil, date: Date, category: OutcomeCategory) {
        self.personID = personID
        self.date = date
        self.category = category
    }

}

extension CaseHistoryOutcome {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
    }

}
