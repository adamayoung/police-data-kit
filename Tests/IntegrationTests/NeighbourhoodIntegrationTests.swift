import Combine
import CoreLocation
import PoliceDataKit
import XCTest

final class NeighbourhoodIntegrationTests: XCTestCase {

    var neighbourhoodService: NeighbourhoodService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        neighbourhoodService = NeighbourhoodService()
    }

    override func tearDown() {
        neighbourhoodService = nil
        cancellables = nil
        super.tearDown()
    }

    func testNeighbourhoodsInPoliceForceForNorfolkConstabulary() async throws {
        let policeForceID = "norfolk"

        let neighbourhoods = try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertGreaterThan(neighbourhoods.count, 0)
    }

    func testNeighbourhoodsInPoliceForceForNorthWalesPolice() async throws {
        let policeForceID = "north-wales"

        let neighbourhoods = try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertGreaterThan(neighbourhoods.count, 0)
    }

    func testNeighbourhoodsInPoliceForceForInvalidPoliceForce() async throws {
        let policeForceID = "ccc"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID)
        } catch let error {
            neighbourhoodError = error as? NeighbourhoodError
        }

        XCTAssertEqual(neighbourhoodError, .notFound)
    }

    func testNeighbourhoodWithIDInPoliceForceForCityCentreLeicestershire() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"

        let neighbourhood = try await neighbourhoodService.neighbourhood(withID: neighbourhoodID,
                                                                         inPoliceForce: policeForceID)

        XCTAssertEqual(neighbourhood.id, neighbourhoodID)
    }

    func testNeighbourhoodWithIDInPoliceForceForCaistorLincolnshire() async throws {
        let neighbourhoodID = "NC09"
        let policeForceID = "lincolnshire"

        let neighbourhood = try await neighbourhoodService.neighbourhood(withID: neighbourhoodID,
                                                                         inPoliceForce: policeForceID)

        XCTAssertEqual(neighbourhood.id, neighbourhoodID)
    }

    func testNeighbourhoodWithIDInPoliceForceForInvalidNeigbourhood() async throws {
        let neighbourhoodID = "111"
        let policeForceID = "lincolnshire"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await neighbourhoodService.neighbourhood(withID: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error {
            neighbourhoodError = error as? NeighbourhoodError
        }

        XCTAssertEqual(neighbourhoodError, .notFound)
    }

    func testNeighbourhoodWithIDInPoliceForceForInvalidPoliceForce() async throws {
        let neighbourhoodID = "NC09"
        let policeForceID = "fff"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await neighbourhoodService.neighbourhood(withID: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error {
            neighbourhoodError = error as? NeighbourhoodError
        }

        XCTAssertEqual(neighbourhoodError, .notFound)
    }

    func testNeighbourhoodAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)

        let neighbourhood = try await neighbourhoodService.neighbourhood(at: leedsCityCentreCoordinate)

        XCTAssertEqual(neighbourhood.id, "LDT_CITY")
        XCTAssertEqual(neighbourhood.name, "Leeds City")
    }

    func testNeighbourhoodAtCoordinateWhenCoordinateIsOutsideOfDataSetRegion() async throws {
        let coordinate = CLLocationCoordinate2D(latitude: 10.11, longitude: 12.21)

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await neighbourhoodService.neighbourhood(at: coordinate)
        } catch let error {
            neighbourhoodError = error as? NeighbourhoodError
        }

        XCTAssertEqual(neighbourhoodError, .locationOutsideOfDataSetRegion)
    }

    func testNeighbourhoodPublisherAtCoordinateForLeedsCityCentre() {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)

        let expectation = self.expectation(description: "NeighbourhoodPublisher")
        var result: Neighbourhood?
        neighbourhoodService.neighbourhoodPublisher(at: leedsCityCentreCoordinate)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { neighbourhood in
                result = neighbourhood
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result?.id, "LDT_CITY")
        XCTAssertEqual(result?.name, "Leeds City")
    }

    func testBoundaryForNeighbourhoodInPoliceForceForWakefieldCentralWestYokrshire() async throws {
        let neighbourhoodID = "WDT_CEN"
        let policeForceID = "west-yorkshire"

        let boundary = try await neighbourhoodService.boundary(forNeighbourhood: neighbourhoodID,
                                                               inPoliceForce: policeForceID)

        XCTAssertEqual(boundary.count, 993)
    }

    func testPoliceOfficersForNeighbourhoodInPoliceForceForWakefieldCentralWestYorkshire() async throws {
        let neighbourhoodID = "WDT_CEN"
        let policeForceID = "west-yorkshire"

        let policeOfficers = try await neighbourhoodService.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                                           inPoliceForce: policeForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testPoliceOfficersForNeighbourhoodInPoliceForceForDoncasterWestSouthYorkshire() async throws {
        let neighbourhoodID = "AB"
        let policeForceID = "south-yorkshire"

        let policeOfficers = try await neighbourhoodService.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                                           inPoliceForce: policeForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testPrioritiesForNeighbourhoodInPoliceForceForDoncasterWestSouthYorkshire() async throws {
        let neighbourhoodID = "AB"
        let policeForceID = "south-yorkshire"

        let priorties = try await neighbourhoodService.priorities(forNeighbourhood: neighbourhoodID,
                                                                  inPoliceForce: policeForceID)

        XCTAssertGreaterThan(priorties.count, 0)
    }

    func testPrioritiesForNeighbourhoodInPoliceForceForGloucesterCityCentreGloucestershire() async throws {
        let neighbourhoodID = "BA1"
        let policeForceID = "gloucestershire"

        let priorties = try await neighbourhoodService.priorities(forNeighbourhood: neighbourhoodID,
                                                                  inPoliceForce: policeForceID)

        XCTAssertGreaterThan(priorties.count, 0)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateForGloucesterCityCentreGloucestershire() async throws {
        let gloucesterCoordinate = CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.2413)

        let policingTeam = try await neighbourhoodService.neighbourhoodPolicingTeam(at: gloucesterCoordinate)

        XCTAssertEqual(policingTeam.force, "gloucestershire")
        XCTAssertEqual(policingTeam.neighbourhood, "BA1")
    }

    func testNeighbourhoodPolicingTeamPublisherAtCoordinateForGloucesterCityCentreGloucestershire() {
        let gloucesterCoordinate = CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.2413)

        let expectation = self.expectation(description: "NeighbourhoodPublisher")
        var result: NeighbourhoodPolicingTeam?
        neighbourhoodService.neighbourhoodPolicingTeamPublisher(at: gloucesterCoordinate)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { policingTeam in
                result = policingTeam
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result?.force, "gloucestershire")
        XCTAssertEqual(result?.neighbourhood, "BA1")
    }

}
