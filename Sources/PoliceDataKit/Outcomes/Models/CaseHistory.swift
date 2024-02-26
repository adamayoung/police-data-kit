//
//  CaseHistory.swift
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
/// A model representing case history of a crime.
///
public struct CaseHistory: Equatable, Codable {

    /// Crime information.
    public let crime: CaseHistoryCrime

    /// Outcomes of the crime.
    public let outcomes: [CaseHistoryOutcome]

    ///
    /// Creates a case history object.
    ///
    /// - Parameters:
    ///   - crime: Crime information.
    ///   - outcomes: Outcomes of the crime.
    ///
    public init(crime: CaseHistoryCrime, outcomes: [CaseHistoryOutcome]) {
        self.crime = crime
        self.outcomes = outcomes
    }

}
