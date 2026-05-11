//
//  RetryHelper.swift
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
import PoliceDataKit

/// Retries `operation` up to `times` times, sleeping between attempts with
/// exponential backoff or the rate-limit `retryAfter` value when available.
///
/// Serialisation against the live API rate limit is handled by the
/// ``IntegrationGateTrait`` applied to each integration suite.
func retry<T: Sendable>(
    times: Int = 3,
    _ operation: @Sendable () async throws -> T
) async throws -> T {
    var lastError: Error?
    for attempt in 0 ..< times {
        do {
            return try await operation()
        } catch {
            lastError = error
            if attempt < times - 1 {
                let delay = retryDelay(for: error, attempt: attempt)
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
        }
    }
    throw lastError ?? URLError(.unknown)
}

/// Retries `operation` only on rate-limit errors; any other error is rethrown
/// immediately so callers can assert against domain-specific cases such as
/// ``CrimeError/notFound``.
func retryOnRateLimit<T: Sendable>(_ operation: @Sendable () async throws -> T) async throws -> T {
    var lastError: Error?
    for attempt in 0 ..< 3 {
        do {
            return try await operation()
        } catch {
            lastError = error
            guard let retryAfter = rateLimitRetryAfter(from: error), attempt < 2 else {
                throw error
            }
            try? await Task.sleep(nanoseconds: UInt64(min(retryAfter, 5) * 1_000_000_000))
        }
    }
    throw lastError ?? URLError(.unknown)
}

private func retryDelay(for error: Error, attempt: Int) -> TimeInterval {
    if let retryAfter = rateLimitRetryAfter(from: error) {
        return min(retryAfter, 30)
    }
    return pow(2.0, Double(attempt)) * 0.5
}

private func rateLimitRetryAfter(from error: Error) -> TimeInterval? {
    switch error {
    case let error as AvailabilityError: error.retryAfter
    case let error as CrimeError: error.retryAfter
    case let error as NeighbourhoodError: error.retryAfter
    case let error as OutcomeError: error.retryAfter
    case let error as PoliceForceError: error.retryAfter
    case let error as StopAndSearchError: error.retryAfter
    default: nil
    }
}

private extension AvailabilityError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}

private extension CrimeError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}

private extension NeighbourhoodError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}

private extension OutcomeError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}

private extension PoliceForceError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}

private extension StopAndSearchError {
    var retryAfter: TimeInterval? {
        if case let .rateLimitExceeded(retryAfter) = self { retryAfter } else { nil }
    }
}
