//
//  Outcome.swift
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
/// A model representing an outcome of a crime.
///
public struct Outcome: Equatable, Codable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?

    /// Date (truncated to the year and month) of the crime.
    public let date: Date

    /// Category of the outcome.
    public let category: OutcomeCategory

    /// Crime information.
    public let crime: OutcomeCrime

    ///
    /// Creates an outcome object.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Date of the crime.
    ///   - category: Category of the outcome.
    ///   - crime: Crime information.
    ///
    public init(
        personID: String? = nil,
        date: Date,
        category: OutcomeCategory,
        crime: OutcomeCrime
    ) {
        self.personID = personID
        self.date = date
        self.category = category
        self.crime = crime
    }

}

extension Outcome {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
        case crime
    }

}
