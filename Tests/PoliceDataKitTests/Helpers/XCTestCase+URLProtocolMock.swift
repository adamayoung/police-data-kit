import Foundation
import XCTest

extension XCTestCase {

    func verify(request: URLRequest) {
        let nextRequest = URLProtocolMock.requests.removeFirst()

        XCTAssertEqual(request, nextRequest)
    }

    func setMockURLSessionResponses(_ responseConfigs: [URL?: (HTTPURLResponse?, Data?)]) {
        URLProtocolMock.responseConfigs = responseConfigs
    }

    func resetMockURLSession() {
        URLProtocolMock.reset()
    }

}
