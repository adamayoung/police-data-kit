//
//  URLProtocolMock.swift
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

final class URLProtocolMock: URLProtocol {

    // nonisolated(unsafe) is safe here: URLProtocolMock is test-only infrastructure
    // accessed sequentially from a single test's setUp/tearDown cycle.
    nonisolated(unsafe) static var responseConfigs = [URL?: (HTTPURLResponse?, Data?)]()
    nonisolated(unsafe) static var requests = [URLRequest]()

    static func reset() {
        responseConfigs = [:]
        requests = []
    }

    override static func canInit(with _: URLRequest) -> Bool {
        true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }

        guard let url = request.url else {
            return
        }

        URLProtocolMock.requests.append(request)

        guard let responseConfig = URLProtocolMock.responseConfigs[url] else {
            let error = URLError(.unsupportedURL)
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let response = responseConfig.0 {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let data = responseConfig.1 {
            client?.urlProtocol(self, didLoad: data)
        }
    }

    override func stopLoading() {}

}
