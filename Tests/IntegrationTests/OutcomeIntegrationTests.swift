import Combine
import CoreLocation
import PoliceDataKit
import XCTest

final class OutcomeIntegrationTests: XCTestCase {

    var outcomeService: OutcomeService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        outcomeService = OutcomeService()
    }

    override func tearDown() {
        outcomeService = nil
        cancellables = nil
        super.tearDown()
    }

    func testStreetLevelOutcomesForStreetForPrincesStreetLondon() async throws {
        let princesStreetLondonStreetID = 1675924
        let date = try XCTUnwrap(Date(isoString: "2022-08-01T12:00:00Z"))

        let outcomes = try await outcomeService.streetLevelOutcomes(forStreet: princesStreetLondonStreetID, date: date)

        XCTAssertGreaterThan(outcomes.count, 0)
    }

    func testStreetLevelOutcomesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2022-08-01T12:00:00Z"))

        let outcomes = try await outcomeService.streetLevelOutcomes(at: leedsCityCentreCoordinate, date: date)

        XCTAssertGreaterThan(outcomes.count, 0)
    }

    func testStreetLevelOutcomesPublisherAtCoordinateForLeedsCityCentre() throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2022-03-01T12:00:00Z"))

        let expectation = self.expectation(description: "OutcomesPublisher")
        var result: [Outcome]?
        outcomeService.streetLevelOutcomesPublisher(at: leedsCityCentreCoordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { outcomes in
                result = outcomes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let outcomes = try XCTUnwrap(result)
        XCTAssertGreaterThan(outcomes.count, 0)
    }

    func testStreetLevelOutcomesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let outcomes = try await outcomeService.streetLevelOutcomes(in: boundary, date: date)

        XCTAssertGreaterThan(outcomes.count, 0)
    }

    func testStreetLevelOutcomesPublisherInCoordinatesForGloucesterCityCentre() throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2022-09-01T12:00:00Z"))

        let expectation = self.expectation(description: "OutcomesPublisher")
        var result: [Outcome]?
        outcomeService.streetLevelOutcomesPublisher(in: boundary, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { outcomes in
                result = outcomes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let outcomes = try XCTUnwrap(result)
        XCTAssertGreaterThan(outcomes.count, 0)
    }

    func testCaseHistoryForCrime() async throws {
        let crimeID = "42c325e012eb6c5bb9558ac25f6817c6d52c1e220651d5d011587221610f163b"

        let caseHistory = try await outcomeService.caseHistory(forCrime: crimeID)

        XCTAssertEqual(caseHistory.crime.crimeID, crimeID)
    }

}
