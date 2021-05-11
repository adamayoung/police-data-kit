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

    func testFetchStreetLevelCrimesInAreaReturnsCrimes() {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(inArea: coordinates, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates, date: date).url)
    }

    func testFetchStreetLevelCrimesInAreaWhenNoDateReturnsCrimes() {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(inArea: coordinates) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates).url)
    }

    func testFetchStreetLevelCrimesInAreaLatitudeLongitudePairsReturnsCrimes() {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let latitudeLongitudePairs = coordinates.map { ($0.latitude, $0.longitude) }
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(inArea: latitudeLongitudePairs, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates, date: date).url)
    }

    func testFetchStreetLevelCrimesInAreaLatitudeLongitudePairsWhenNotDateReturnsCrimes() {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let latitudeLongitudePairs = coordinates.map { ($0.latitude, $0.longitude) }
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(inArea: latitudeLongitudePairs) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates).url)
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

    func testStreetLevelCrimesInAreaPublisherReturnsCrimes() throws {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: coordinates, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates, date: date).url)
    }

    func testStreetLevelCrimesInAreaPublisherWhenNoDateReturnsCrimes() throws {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: coordinates),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates).url)
    }

    func testStreetLevelCrimesInAreaLatitudeLongitudePairsPublisherReturnsCrimes() throws {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let latitudeLongitudePairs = coordinates.map { ($0.latitude, $0.longitude) }
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: latitudeLongitudePairs,
                                                                               date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates, date: date).url)
    }

    func testStreetLevelCrimesInAreaLatitudeLongitudePairsPublisherWhenNoDateReturnsCrimes() throws {
        let coordinates = [
            Coordinate(latitude: 52.6688, longitude: -0.750049),
            Coordinate(latitude: 54.3698, longitude: -0.713541)
        ]
        let latitudeLongitudePairs = coordinates.map { ($0.latitude, $0.longitude) }
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: latitudeLongitudePairs),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelInCustomArea(coordinates: coordinates).url)
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
