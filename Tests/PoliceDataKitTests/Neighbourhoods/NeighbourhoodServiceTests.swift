import Combine
import MapKit
@testable import PoliceDataKit
import XCTest

final class NeighbourhoodServiceTests: XCTestCase {

    var service: NeighbourhoodService!
    var apiClient: MockAPIClient!
    var cache: NeighbourhoodMockCache!
    var availableDataRegion: MKCoordinateRegion!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = NeighbourhoodMockCache()
        availableDataRegion = .test
        cancellables = Set<AnyCancellable>()
        service = NeighbourhoodService(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    override func tearDown() {
        service = nil
        cancellables = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

}

extension NeighbourhoodServiceTests {

    func testNeighboursWhenNotCachedReturnsNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.add(response: .success(NeighbourhoodReference.mocks))

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path)
    }

    func testNeighboursWhenCachedReturnsCachedNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        await cache.setNeighbourhoods(expectedResult, inPoliceForce: policeForceID)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testNeighboursWhenNotCachedAndReturnsNeighbourhoodReferencesShouldCacheResult() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.add(response: .success(NeighbourhoodReference.mocks))
        _ = try await service.neighbourhoods(inPoliceForce: policeForceID)

        let cachedResult = await cache.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodWhenNotCachedReturnsNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.add(response: .success(Neighbourhood.mock))

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path
        )
    }

    func testNeighbourhoodWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let id = "NC04"
        let policeForceID = "leicestershire"
        apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testNeighbourhoodWhenCachedReturnsCachedNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        await cache.setNeighbourhood(expectedResult, withID: id, inPoliceForce: policeForceID)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testNeighbourhoodWhenNotCachedAndReturnsNeighbourhoodShouldCacheResult() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.add(response: .success(Neighbourhood.mock))
        _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        let cachedResult = await cache.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodAtCoordinateReturnsNeighbourhood() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let neighbourhoodPolicingTeam = NeighbourhoodPolicingTeam.mock
        let expectedResult = Neighbourhood.mock

        apiClient.add(response: .success(neighbourhoodPolicingTeam))
        apiClient.add(response: .success(expectedResult))

        let result = try await service.neighbourhood(at: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 2)
        XCTAssertEqual(
            apiClient.requestedURLs.first,
            NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path
        )
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.details(
                id: neighbourhoodPolicingTeam.neighbourhood,
                policeForceID: neighbourhoodPolicingTeam.force
            ).path
        )
    }

    func testNeighbourhoodPublisherAtCoordinateReturnsNeighbourhood() throws {
        let coordinate = CLLocationCoordinate2D.mock
        let neighbourhoodPolicingTeam = NeighbourhoodPolicingTeam.mock
        let expectedResult = Neighbourhood.mock

        apiClient.add(response: .success(neighbourhoodPolicingTeam))
        apiClient.add(response: .success(expectedResult))

        let expectation = self.expectation(description: "NeighbourhoodPublisher")
        var result: Neighbourhood?
        service.neighbourhoodPublisher(at: coordinate)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { neighbourhood in
                result = neighbourhood
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 2)
        XCTAssertEqual(
            apiClient.requestedURLs.first,
            NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path
        )
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.details(
                id: neighbourhoodPolicingTeam.neighbourhood,
                policeForceID: neighbourhoodPolicingTeam.force
            ).path
        )
    }

}

extension NeighbourhoodServiceTests {

    func testBoundaryWhenNotCachedReturnsBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        apiClient.add(response: .success(CLLocationCoordinate2D.mocks))

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testBoundaryWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testBoundaryWhenCachedReturnsCachedBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        await cache.setBoundary(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testBoundaryWhenNotCachedAndReturnsBoundaryShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        apiClient.add(response: .success(CLLocationCoordinate2D.mocks))
        _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}

extension NeighbourhoodServiceTests {

    func testPoliceOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.add(response: .success(PoliceOfficer.mocks))

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                      inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testPoliceOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        await cache.setPoliceOfficers(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testPoliceOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.add(response: .success(PoliceOfficer.mocks))
        _ = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}

extension NeighbourhoodServiceTests {

    func testPrioritiesWhenNotCachedReturnsNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.add(response: .success(NeighbourhoodPriority.mocks))

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testPrioritiesWhenCachedReturnsCachedNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        await cache.setPriorities(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testPrioritiesWhenNotCachedAndReturnsNeighbourhoodPrioritiesShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.add(response: .success(NeighbourhoodPriority.mocks))
        _ = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}

extension NeighbourhoodServiceTests {

    func testNeighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.add(response: .success(NeighbourhoodPolicingTeam.mock))

        let result = try await service.neighbourhoodPolicingTeam(at: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path
        )
    }

    func testNeighbourhoodPolicingTeamAtCoordinateWhenNotFoundThrowsNotFoundError() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testNeighbourhoodPolicingTeamAtCoordsWhenNotInAvailableDataRegionThrowsError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.add(response: .success(expectedResult))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testNeighbourhoodPolicingTeamPublisherAtCoordinateReturnsNeighbourhoodPolicingTeam() {
        let coordinate = CLLocationCoordinate2D.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.add(response: .success(NeighbourhoodPolicingTeam.mock))

        let expectation = self.expectation(description: "NeighbourhoodPolicingTeamPublisher")
        var result: NeighbourhoodPolicingTeam?
        service.neighbourhoodPolicingTeamPublisher(at: coordinate)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { policingTeam in
                result = policingTeam
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path
        )
    }

}
