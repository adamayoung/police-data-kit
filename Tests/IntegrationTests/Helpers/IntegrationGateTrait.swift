//
//  IntegrationGateTrait.swift
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

import Testing

/// A trait that runs at most one decorated test at a time across the whole test
/// run.
///
/// Applied to every integration suite so that calls to the live, rate-limited
/// `data.police.uk` API never exceed one in-flight request, regardless of how
/// the runner schedules suites in parallel.
struct IntegrationGateTrait: TestTrait, SuiteTrait, TestScoping {

    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: @Sendable () async throws -> Void
    ) async throws {
        await IntegrationGate.shared.acquire()
        defer { Task { await IntegrationGate.shared.release() } }
        try await function()
    }

}

extension Trait where Self == IntegrationGateTrait {

    /// Serialises every annotated test across the entire test run.
    static var integrationGate: Self { IntegrationGateTrait() }

}

actor IntegrationGate {

    static let shared = IntegrationGate()

    private var busy = false
    private var waiters: [CheckedContinuation<Void, Never>] = []

    func acquire() async {
        if !busy {
            busy = true
            return
        }
        await withCheckedContinuation { continuation in
            waiters.append(continuation)
        }
    }

    func release() {
        if waiters.isEmpty {
            busy = false
            return
        }
        let next = waiters.removeFirst()
        next.resume()
    }

}
