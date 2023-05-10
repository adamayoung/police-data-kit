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
