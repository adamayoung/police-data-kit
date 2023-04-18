@testable import PoliceAPI
import XCTest

final class MockAPIClient: APIClient {

    var response: Any?
    private(set) var lastPath: URL?

    func get<Response>(path: URL) async throws -> Response where Response: Decodable {
        self.lastPath = path

        guard let result = response as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            throw PoliceDataError.unknown
        }

        return result
    }

    func reset() {
        response = nil
        lastPath = nil
    }

}
