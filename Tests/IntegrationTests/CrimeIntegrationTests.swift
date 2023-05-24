import Combine
import CoreLocation
import PoliceDataKit
import XCTest

final class CrimeIntegrationTests: XCTestCase {

    var crimeService: CrimeService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        crimeService = CrimeService()
    }

    override func tearDown() {
        crimeService = nil
        cancellables = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(at: leedsCityCentreCoordinate, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testStreetLevelCrimesPublisherAtCoordinateForLeedsCityCentre() throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let expectation = self.expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        crimeService.streetLevelCrimesPublisher(at: leedsCityCentreCoordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let crimes = try XCTUnwrap(result)
        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testStreetLevelCrimesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(in: boundary, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testStreetLevelCrimesPublisherInCoordinatesForGloucesterCityCentre() throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let expectation = self.expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        crimeService.streetLevelCrimesPublisher(in: boundary, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let crimes = try XCTUnwrap(result)
        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesForStreetAtSaundersWayLondon() async throws {
        let saundersWayLondonStreetID = 1705005
        let date = try XCTUnwrap(Date(isoString: "2023-02-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(forStreet: saundersWayLondonStreetID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesWithNoLocationForHertfordshireConstabulary() async throws {
        let policeForceID = "hertfordshire"
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(at: leedsCityCentreCoordinate, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesPublisherAtCoordinateForLeedsCityCentre() throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let expectation = self.expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        crimeService.crimesPublisher(at: leedsCityCentreCoordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let crimes = try XCTUnwrap(result)
        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesWithNoLocationInPoliceForceForSurrey() async throws {
        let policeForceID = "surrey"
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimeCategories() async throws {
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimeCategories = try await crimeService.crimeCategories(forDate: date)

        XCTAssertGreaterThan(crimeCategories.count, 0)
    }

}
