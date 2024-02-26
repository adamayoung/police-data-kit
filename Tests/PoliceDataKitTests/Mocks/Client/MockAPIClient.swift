//
//  MockAPIClient.swift
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

final class MockAPIClient: APIClient {

    var responses: [Result<Any, Error>] = []
    private(set) var requestedURLs: [URL] = []

    private var responseIndex = 0

    func get<Response>(path: URL) async throws -> Response where Response: Decodable {
        requestedURLs.append(path)

        let response = response(at: responseIndex)
        responseIndex += 1

        guard let result = try response?.get() as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            throw APIClientError.unknown
        }

        return result
    }

}

extension MockAPIClient {

    func add(response: Result<Any, Error>) {
        responses.append(response)
    }

    func reset() {
        responses = []
        responseIndex = 0
        requestedURLs = []
    }

}

extension MockAPIClient {

    private func response(at index: Int) -> Result<Any, Error>? {
        guard index < responses.count else {
            return nil
        }

        return responses[index]
    }

}
