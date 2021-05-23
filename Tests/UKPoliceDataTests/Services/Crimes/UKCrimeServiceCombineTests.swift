#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKCrimeServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    var service: UKCrimeService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKCrimeService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

}

extension UKCrimeServiceCombineTests {

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

}

extension UKCrimeServiceCombineTests {

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

}

extension UKCrimeServiceCombineTests {

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

}

extension UKCrimeServiceCombineTests {

    func testCaseHistoryPublisherReturnsCaseHistory() throws {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.caseHistoryPublisher(forCrime: crimeID), storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.caseHistory(crimeID: crimeID).url)
    }

}

extension UKCrimeServiceCombineTests {

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
