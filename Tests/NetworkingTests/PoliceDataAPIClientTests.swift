@testable import Networking
import PoliceAPIData
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

    func testGetWhenRequestFailsThrowsNetworkError() async throws {
        let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue)
        MockURLProtocol.failError = expectedError
        let path = try XCTUnwrap(URL(string: "/error"))

        do {
           _ = try await apiClient.get(path: path) as String
        } catch let error as APIClientError {
            switch error {
            case .network(let error as NSError):
                XCTAssertEqual(error.code, expectedError.code)
                return
            default:
                break
            }
        }

        XCTFail("Expected error to be thrown")
    }

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
