//
//  PoliceDataAPIClientTests.swift
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
@testable import PoliceDataKit
import Testing

/// MockURLProtocol uses nonisolated(unsafe) static state; serialised to avoid data races.
@Suite("PoliceDataAPIClient", .serialized)
struct PoliceDataAPIClientTests {

    let apiClient: PoliceDataAPIClient
    let baseURL: URL
    let urlSession: URLSession
    let serialiser: JSONSerialiser

    init() throws {
        self.baseURL = try #require(URL(string: "https://some.domain.com/path"))

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        self.urlSession = URLSession(configuration: configuration)
        self.serialiser = JSONSerialiser(decoder: JSONDecoder())
        self.apiClient = PoliceDataAPIClient(baseURL: baseURL, urlSession: urlSession, serialiser: serialiser)

        MockURLProtocol.reset()
    }

    #if !os(watchOS)
        @Test("get when request fails throws network error")
        func getWhenRequestFailsThrowsNetworkError() async throws {
            let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue)
            MockURLProtocol.failError = expectedError
            let path = try #require(URL(string: "/error"))

            var caughtError: APIClientError?
            do {
                _ = try await apiClient.get(path: path) as String
            } catch {
                caughtError = error
            }

            if case let .network(networkError as NSError) = caughtError {
                #expect(networkError.code == expectedError.code)
            } else {
                Issue.record("Expected .network error to be thrown, got \(String(describing: caughtError))")
            }
        }
    #endif

    @Test("get when response status code is 404 returns not found error")
    func getWhenResponseStatusCodeIs404ReturnsNotFoundError() async throws {
        MockURLProtocol.responseStatusCode = 404
        let path = try #require(URL(string: "/error"))

        var caughtError: APIClientError?
        do {
            _ = try await apiClient.get(path: path) as String
        } catch {
            caughtError = error
        }

        if case .notFound = caughtError {
            // pass
        } else {
            Issue.record("Expected .notFound error to be thrown, got \(String(describing: caughtError))")
        }
    }

    @Test("get when response status code is 500 returns unknown error")
    func getWhenResponseStatusCodeIs500ReturnsUnknownError() async throws {
        MockURLProtocol.responseStatusCode = 500
        let path = try #require(URL(string: "/error"))

        var caughtError: APIClientError?
        do {
            _ = try await apiClient.get(path: path) as String
        } catch {
            caughtError = error
        }

        if case .unknown = caughtError {
            // pass
        } else {
            Issue.record("Expected .unknown error to be thrown, got \(String(describing: caughtError))")
        }
    }

    @Test("get when response has valid data returns decoded object")
    func getWhenResponseHasValidDataReturnsDecodedObject() async throws {
        let expectedResult = MockObject()
        MockURLProtocol.data = expectedResult.data
        let path = try #require(URL(string: "/object"))

        let result: MockObject = try await apiClient.get(path: path)

        #expect(result == expectedResult)
    }

    @Test("get URL request Accept header set to application/json")
    func getURLRequestAcceptHeaderSetToApplicationJSON() async throws {
        let expectedResult = "application/json"
        let path = try #require(URL(string: "/object"))

        _ = try? await apiClient.get(path: path) as String

        let result = MockURLProtocol.lastRequest?.value(forHTTPHeaderField: "Accept")

        #expect(result == expectedResult)
    }

}

extension PoliceDataAPIClientTests {

    private struct MockObject: Codable, Equatable {

        let id: UUID

        var data: Data {
            // swiftlint:disable force_try
            try! JSONEncoder().encode(self)
            // swiftlint:enable force_try
        }

        init(id: UUID = .init()) {
            self.id = id
        }
    }

}
