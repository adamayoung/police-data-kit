@testable import UKPoliceData
import XCTest

#if canImport(Combine)
import Combine
#endif

class UKCrimeServiceTests: XCTestCase {

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
        let coordinate = Coordinate.mock
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
                       CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testFetchStreetLevelCrimesAtCoorindateWhenNoDateReturnsCrimes() {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate).url)
    }

    func testFetchStreetLevelCrimesInAreaReturnsCrimes() {
        let coordinates = Coordinate.mocks
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
                       CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).url)
    }

    func testFetchStreetLevelCrimesInAreaWhenNoDateReturnsCrimes() {
        let coordinates = Coordinate.mocks
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelCrimes(inArea: coordinates) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates).url)
    }

    func testFetchStreetLevelOutcomesForStreetReturnsOutcomes() {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(forStreet: streetID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url)
    }

    func testFetchStreetLevelOutcomesForStreetWhenNoDateReturnsOutcomes() {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(forStreet: streetID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url)
    }

    func testFetchStreetLevelOutcomesAtCoordinateReturnsOutcomes() {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date) .url)
    }

    func testFetchStreetLevelOutcomesAtCoordinateWhenNoDateReturnsOutcomes() {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate) .url)
    }

    func testFetchStreetLevelOutcomesInAreaReturnsOutcomes() {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(inArea: coordinates, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date) .url)
    }

    func testFetchStreetLevelOutcomesInAreaWhenNoDateReturnsOutcomes() {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(inArea: coordinates) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates) .url)
    }

    func testFetchCrimesAtLocationForStreetReturnsCrimes() {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesAtLocation(forStreet: streetID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).url)
    }

    func testFetchCrimesAtLocationForStreetWhenNoDateReturnsCrimes() {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesAtLocation(forStreet: streetID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID).url)
    }

    func testFetchCrimesAtLocationAtCoordinateReturnsCrimes() {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesAtLocation(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testFetchCrimesAtLocationAtCoordinateWhenNoDateReturnsCrimes() {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesAtLocation(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate).url)
    }

    func testFetchCrimesWithNoLocationReturnsCrimes() {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID,
                                                           date: date).url)
    }

    func testFetchCrimesWithNoLocationWhenNoCategoryOrDateReturnsCrimes() {
        let policeForceID = PoliceForce.mock.id
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCrimesWithNoLocation(inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesWithNoLocation(categoryID: CrimeCategory.defaultID,
                                                           policeForceID: policeForceID).url)
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
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testStreetLevelCrimesAtCoorindatePublisherWhenNoDateReturnsCrimes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate).url)
    }

    func testStreetLevelCrimesInAreaPublisherReturnsCrimes() throws {
        let coordinates = Coordinate.mocks
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: coordinates, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).url)
    }

    func testStreetLevelCrimesInAreaPublisherWhenNoDateReturnsCrimes() throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelCrimesPublisher(inArea: coordinates),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates).url)
    }

    func testStreetLevelOutcomesForStreetPublisherReturnsOutcomes() throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(forStreet: streetID,
                                                                               date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url)
    }

    func testStreetLevelOutcomesForStreetPublisherWhenNoDateReturnsOutcomes() throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(forStreet: streetID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url)
    }

    func testStreetLevelOutcomesAtCoordinatePublisherReturnsOutcomes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date) .url)
    }

    func testStreetLevelOutcomesAtCoordinatePublisherWhenNoDateReturnsOutcomes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate) .url)
    }

    func testStreetLevelOutcomesInAreaPublisherReturnsOutcomes() throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(inArea: coordinates, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date) .url)
    }

    func testStreetLevelOutcomesInAreaPublisherWhenNoDateReturnsOutcomes() throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(inArea: coordinates),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates) .url)
    }

    func testCrimesAtLocationForStreetPublisherReturnsCrimes() throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesAtLocationPublisher(forStreet: streetID, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).url)
    }

    func testCrimesAtLocationForStreetPublisherWhenNoDateReturnsCrimes() throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesAtLocationPublisher(forStreet: streetID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID).url)
    }

    func testCrimesAtLocationAtCoordinatePublisherReturnsCrimes() throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesAtLocationPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).url)
    }

    func testCrimesAtLocationAtCoordinatePublisherWhenNoDateReturnsCrimes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesAtLocationPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate).url)
    }

    func testCrimesWithNoLocationPublisherReturnsCrimes() throws {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesWithNoLocationPublisher(forCategory: categoryID,
                                                                                  inPoliceForce: policeForceID,
                                                                                  date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID,
                                                           date: date).url)
    }

    func testCrimesWithNoLocationPublisherWhenNoCategoryOrDateReturnsCrimes() throws {
        let policeForceID = PoliceForce.mock.id
        let expectedResult = Crime.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.crimesWithNoLocationPublisher(inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.crimesWithNoLocation(categoryID: CrimeCategory.defaultID,
                                                           policeForceID: policeForceID).url)
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
