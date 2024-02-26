//
//  Gender.swift
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
/// The gender of a person.
///
public enum Gender: String, CaseIterable, CustomStringConvertible, Codable {

    /// Male.
    case male = "Male"

    /// Female.
    case female = "Female"

    /// Other.
    case other = "Other"

    /// The localized string describing the gender.
    public var description: String {
        switch self {
        case .male:
            NSLocalizedString("MALE", bundle: .module, comment: "Male")

        case .female:
            NSLocalizedString("FEMALE", bundle: .module, comment: "Female")

        case .other:
            NSLocalizedString("OTHER", bundle: .module, comment: "Other")
        }
    }
}
