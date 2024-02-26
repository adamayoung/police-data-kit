//
//  DataSet.swift
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
/// A model representing a data set.
///
public struct DataSet: Equatable, Codable {

    /// Year and month of all available street level crime data.
    public let date: Date

    /// A list of police force identifiers for police forces that have provided stop and search data for this month.
    public let stopAndSearch: [String]

    ///
    /// Creates a data set object.
    ///
    /// - Parameters:
    ///   - date: Year and month of all available street level crime data.
    ///   - stopAndSearch: A list of police force identifiers for police forces that have provided stop and search data for this month.
    ///
    public init(date: Date, stopAndSearch: [String]) {
        self.date = date
        self.stopAndSearch = stopAndSearch
    }

}

extension DataSet {

    private enum CodingKeys: String, CodingKey {
        case date
        case stopAndSearch = "stop-and-search"
    }

}
