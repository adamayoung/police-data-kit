@testable import UKPoliceData
import XCTest

#if !os(Linux)
class PoliceDataAPIClientTests: XCTestCase {

    var baseURL: URL!
    var client: PoliceDataAPIClient!

    override func setUp() {
        super.setUp()

        baseURL = URL(string: "https://localhost/api")
        client = PoliceDataAPIClient(baseURL: baseURL, urlSession: URLSession(configuration: .mock),
                                     jsonDecoder: .policeDataAPI)
    }

    override func tearDown() {
        baseURL = nil
        client = nil

        resetMockURLSession()

        super.tearDown()
    }

    func testGetReturnsPerson() throws {
        let person = Person.mock
        let data = try person.data()
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        setMockURLSessionResponses([url: (response, data)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            XCTAssertEqual(person, try? result.get())

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenURLErrorReturnsNetworkError() throws {
        let person = Person.mock
        let path = URL(string: "/people/\(person.id)")!

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure:
                XCTAssertTrue(true)

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenResponseIsNilReturnsUnknownError() throws {
        let person = Person.mock
        let data = try person.data()
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        setMockURLSessionResponses([url: (nil, data)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknown)

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenResponseStatusCodeIs404ReturnsNotFoundError() throws {
        let person = Person.mock
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
        setMockURLSessionResponses([url: (response, nil)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .notFound)

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenResponseStatusCodeIs500ReturnsUnknownError() throws {
        let person = Person.mock
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        setMockURLSessionResponses([url: (response, nil)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknown)

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenDataIsNilReturnsUnknownError() throws {
        let person = Person.mock
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        setMockURLSessionResponses([url: (response, nil)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknown)

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetWhenDataCannotBeDecodedReturnsDecodeError() throws {
        let person = Person.mock
        let data = "{\"title\": \"something\"}".data(using: .utf8)
        let path = URL(string: "/people/\(person.id)")!
        let url = baseURL
            .appendingPathComponent("people")
            .appendingPathComponent(person.id)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        setMockURLSessionResponses([url: (response, data)])

        let expectation = XCTestExpectation(description: "getRequest")
        client.get(path: path) { (result: Result<Person, PoliceDataError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .decode(MockError()))

            default:
                XCTFail("Should return error")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

}

private struct Person: Codable, Equatable {

    let id: String
    let firstName: String
    let lastName: String
    let height: Int
    let homepage: URL

}

extension Person {

    static var mock: Person {
        Person(
            id: "1234",
            firstName: "John",
            lastName: "Smith",
            height: 180,
            homepage: URL(string: "https://www.johnsmith.com")!
        )
    }

    func data() throws -> Data {
        try JSONEncoder().encode(self)
    }

}
#endif
