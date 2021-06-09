@testable import UKPoliceData
import XCTest

#if canImport(Combine)
import Combine
#endif

class MockAPIClient: APIClient {

    var response: Any?
    private(set) var lastPath: URL?

    func get<Response>(path: URL,
                       completion: @escaping (Result<Response, PoliceDataError>) -> Void) where Response: Decodable {
        self.lastPath = path

        guard let decodedResponse = response as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            return
        }

        DispatchQueue.main.simulateWaitForNetwork {
            completion(.success(decodedResponse))
        }
    }

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(path: URL) -> AnyPublisher<Response, PoliceDataError> {
        self.lastPath = path

        guard let result = response as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            return Empty()
                .setFailureType(to: PoliceDataError.self)
                .eraseToAnyPublisher()
        }

        return Just(result)
            .setFailureType(to: PoliceDataError.self)
            .eraseToAnyPublisher()
    }
    #endif

    #if swift(>=5.5)
    @available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func get<Response>(path: URL) async throws -> Response where Response : Decodable {
        self.lastPath = path

        guard let result = response as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            throw PoliceDataError.unknown
        }

        return result
    }
    #endif

    func reset() {
        response = nil
        lastPath = nil
    }

}
