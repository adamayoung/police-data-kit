@testable import UKPoliceData
import XCTest

#if canImport(Combine)
import Combine
#endif

final class UKCrimeServiceTests: XCTestCase {

    #if canImport(Combine)
    var cancellables: Set<AnyCancellable> = []
    #endif
    var service: UKCrimeService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()

        apiClient = MockAPIClient()
        service = UKCrimeService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient.reset()
        apiClient = nil
        service = nil

        super.tearDown()
    }

    func testFetchStreetLevelCrimesAtCoorindateReturnsCrimes() {
        let coordinate = Coordinate(latitude: 52.6688, longitude: -0.750049)
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testFetchStreetLevelCrimesAtCoorindateWhenNoDateReturnsCrimes() {
        let coordinate = Coordinate(latitude: 52.6688, longitude: -0.750049)
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate).url)
    }

    func testFetchStreetLevelCrimesAtLatitudeLongitudeReturnsCrimes() {
        let latitude = 52.6688
        let longitude = -0.750049
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(atLatitude: latitude, longitude: longitude, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: Coordinate(latitude: latitude,
                                                                                        longitude: longitude),
                                                                 date: date).url)
    }

    func testFetchStreetLevelCrimesAtLatitudeLongitudeWhenNoDateReturnsCrimes() {
        let latitude = 52.6688
        let longitude = -0.750049
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(atLatitude: latitude, longitude: longitude) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: Coordinate(latitude: latitude,
                                                                                        longitude: longitude)).url)
    }

    func testFetchCategoriesReturnsCrimeCategories() {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCategories(date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: date).url)
    }

}

#if canImport(Combine)
extension UKCrimeServiceTests {

    func testStreetLevelCrimesAtCoorindatePublisherReturnsCrimes() throws {
        let coordinate = Coordinate(latitude: 52.6688, longitude: -0.750049)
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testStreetLevelCrimesAtCoorindatePublisherWhenNoDateReturnsCrimes() throws {
        let coordinate = Coordinate(latitude: 52.6688, longitude: -0.750049)
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate).url)
    }

    func testStreetLevelCrimesAtLatitudeLongitudePublisherReturnsCrimes() throws {
        let latitude = 52.6688
        let longitude = -0.750049
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atLatitude: latitude,
                                                                               longitude: longitude, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: Coordinate(latitude: latitude,
                                                                                        longitude: longitude),
                                                                 date: date).url)
    }

    func testStreetLevelCrimesAtLatitudeLongitudePublisherWhenNoDateReturnsCrimes() throws {
        let latitude = 52.6688
        let longitude = -0.750049
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atLatitude: latitude,
                                                                               longitude: longitude),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: Coordinate(latitude: latitude,
                                                                                        longitude: longitude)).url)
    }

    func testCategoriesPublisherReturnsCrimeCategories() throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.categoriesPublisher(date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: date).url)
    }

}
#endif
