//
//  CrimeCategory.swift
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
/// A model representing a category of a crime.
///
public struct CrimeCategory: Identifiable, Decodable, Equatable {

    /// The default crime category which includes all crimes.
    public static let `default` = CrimeCategory(
        id: "all-crime",
        name: "All Crimes"
    )

    /// Identifier of a crime category.
    public let id: String

    /// Name of the crime category.
    public let name: String

    /// Creates a crime category object.
    ///
    /// - Parameters:
    ///   - id: Identifier of a crime category.
    ///   - name: Name of the crime category.
    ///
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension CrimeCategory {

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }

}
