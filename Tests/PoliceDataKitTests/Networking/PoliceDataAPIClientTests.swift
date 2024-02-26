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

@testable import PoliceDataKit
import XCTest

final class PoliceDataAPIClientTests: XCTestCase {

    var apiClient: PoliceDataAPIClient!
    var baseURL: URL!
    var urlSession: URLSession!
    var serialiser: JSONSerialiser!

    override func setUp() {
        super.setUp()
        baseURL = URL(string: "https://some.domain.com/path")

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        serialiser = JSONSerialiser(decoder: JSONDecoder())
        apiClient = PoliceDataAPIClient(baseURL: baseURL, urlSession: urlSession, serialiser: serialiser)
    }

    override func tearDown() {
        apiClient = nil
        serialiser = nil
        baseURL = nil
        MockURLProtocol.reset()
        super.tearDown()
    }

    #if !os(watchOS)
        func testGetWhenRequestFailsThrowsNetworkError() async throws {
            let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue)
            MockURLProtocol.failError = expectedError
            let path = try XCTUnwrap(URL(string: "/error"))

            do {
                _ = try await apiClient.get(path: path) as String
            } catch let error as APIClientError {
                switch error {
                case let .network(error as NSError):
                    XCTAssertEqual(error.code, expectedError.code)
                    return
                default:
                    break
                }
            }

            XCTFail("Expected error to be thrown")
        }
    #endif

    func testGetWhenResponseStatusCodeIs404ReturnsNotFoundError() async throws {
        MockURLProtocol.responseStatusCode = 404
        let path = try XCTUnwrap(URL(string: "/error"))

        do {
            _ = try await apiClient.get(path: path) as String
        } catch let error as APIClientError {
            switch error {
            case .notFound:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected not found error to be thrown")
    }

    func testGetWhenResponseStatusCodeIs500ReturnsUnknownError() async throws {
        MockURLProtocol.responseStatusCode = 500
        let path = try XCTUnwrap(URL(string: "/error"))

        do {
            _ = try await apiClient.get(path: path) as String
        } catch let error as APIClientError {
            switch error {
            case .unknown:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected unknown error to be thrown")
    }

    func testGetWhenResponseHasValidDataReturnsDecodedObject() async throws {
        let expectedResult = MockObject()
        MockURLProtocol.data = expectedResult.data
        let path = try XCTUnwrap(URL(string: "/object"))

        let result: MockObject = try await apiClient.get(path: path)

        XCTAssertEqual(result, expectedResult)
    }

    func testGetURLRequestAcceptHeaderSetToApplicationJSON() async throws {
        let expectedResult = "application/json"
        let path = try XCTUnwrap(URL(string: "/object"))

        _ = try? await apiClient.get(path: path) as String

        let result = MockURLProtocol.lastRequest?.value(forHTTPHeaderField: "Accept")

        XCTAssertEqual(result, expectedResult)
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
