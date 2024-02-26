//
//  PoliceForceError.swift
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
/// An error PoliceDataKit returns.
///
public enum PoliceForceError: LocalizedError, Equatable {

    /// An error indicating a police force could not be found.
    case notFound

    /// An error indicating there was a network problem.
    case network(Error)

    /// An unknown error.
    case unknown

}

public extension PoliceForceError {

    /// A localized message describing what error occurred.
    var errorDescription: String? {
        switch self {
        case .notFound:
            NSLocalizedString("NOT_FOUND", bundle: .module, comment: "Not found error")

        case .network:
            NSLocalizedString("NETWORK_ERROR", bundle: .module, comment: "Network error")

        case .unknown:
            NSLocalizedString("UNKNOWN_ERROR", bundle: .module, comment: "Unknown error")
        }
    }

}

public extension PoliceForceError {

    /// Returns a Boolean value indicating whether two `PoliceForceError`s are equal.
    static func == (lhs: PoliceForceError, rhs: PoliceForceError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            true

        case (.network, .network):
            true

        case (.unknown, .unknown):
            true

        default:
            false
        }
    }

}
