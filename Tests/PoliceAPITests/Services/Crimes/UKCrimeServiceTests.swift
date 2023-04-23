@testable import PoliceAPI
import XCTest

final class UKCrimeServiceTests: XCTestCase {

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

    func testStreetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelCrimesAtCoordinateWhenNoDateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testStreetLevelCrimesInAreaReturnsCrimes() async throws {
        let boundary = Boundary.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(inArea: boundary, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: date).path
        )
    }

    func testStreetLevelCrimesInAreaWhenNoDateReturnsCrimes() async throws {
        let boundary = Boundary.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(inArea: boundary)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: Date()).path
        )
    }

    func testCrimesForStreetReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path
        )
    }

    func testCrimesForStreetWhenNoDateReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(forStreet: streetID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: Date()).path
        )
    }

    func testCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testCrimesAtCoordinateWhenNoDateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testCrimesWithNoLocationReturnsCrimes() async throws {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID,
                                                            date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date).path
        )
    }

    func testCrimesWithNoLocationWhenNoCategoryOrDateReturnsCrimes() async throws {
        let policeForceID = PoliceForce.mock.id
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimesWithNoLocation(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesWithNoLocation(categoryID: CrimeCategory.defaultID, policeForceID: policeForceID,
                                                date: Date()).path
        )
    }

    func testCrimeCategoriesReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: date).path)
    }

}
