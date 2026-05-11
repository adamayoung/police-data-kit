//
//  AvailabilityError.swift
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
public enum AvailabilityError: LocalizedError, Equatable, Sendable {

    /// An error indicating there was a network problem.
    case network(Error)

    /// An error indicating the API rate limit has been exceeded.
    ///
    /// The associated value, if present, is the number of seconds the API requested clients to wait
    /// before retrying.
    case rateLimitExceeded(retryAfter: TimeInterval?)

    /// An unknown error.
    case unknown

}

public extension AvailabilityError {

    /// A localized message describing what error occurred.
    var errorDescription: String? {
        switch self {
        case .network:
            NSLocalizedString("NETWORK_ERROR", bundle: .module, comment: "Network error")

        case .rateLimitExceeded:
            NSLocalizedString("RATE_LIMIT_EXCEEDED_ERROR", bundle: .module, comment: "Rate limit exceeded error")

        case .unknown:
            NSLocalizedString("UNKNOWN_ERROR", bundle: .module, comment: "Unknown error")
        }
    }

}

public extension AvailabilityError {

    /// Returns a Boolean value indicating whether two `AvailabilityError`s are equal.
    static func == (lhs: AvailabilityError, rhs: AvailabilityError) -> Bool {
        switch (lhs, rhs) {
        case (.network, .network):
            true

        case (.rateLimitExceeded, .rateLimitExceeded):
            true

        case (.unknown, .unknown):
            true

        default:
            false
        }
    }

}
