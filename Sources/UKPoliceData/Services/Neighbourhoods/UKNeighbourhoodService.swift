import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKNeighbourhoodService: NeighbourhoodService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchAll(inPoliceForce policeForceID: String,
                  completion: @escaping (Result<[NeighbourhoodReference], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID), completion: completion)
    }

    func fetchDetails(forNeighbourhood id: String, inPoliceForce policeForceID: String,
                      completion: @escaping (Result<Neighbourhood, PoliceDataError>) -> Void) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID),
                      completion: completion)
    }

    func fetchBoundary(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                       completion: @escaping (Result<[Coordinate], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID,
                                                                policeForceID: policeForceID),
                      completion: completion)
    }

    func fetchPoliceOfficers(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                             completion: @escaping (_ result: Result<[PoliceOfficer], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                                      policeForceID: policeForceID),
                      completion: completion)
    }

    func fetchPriorities(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                         completion: @escaping (_ result: Result<[NeighbourhoodPriority], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID,
                                                                  policeForceID: policeForceID),
                      completion: completion)
    }

    func fetchNeighbourhoodPolicingTeam(
        atCoordinate coordinate: Coordinate,
        completion: @escaping (_ result: Result<NeighbourhoodPolicingTeam, PoliceDataError>) -> Void
    ) {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate),
                      completion: completion)
    }

}

#if canImport(Combine)
extension UKNeighbourhoodService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func neighbourhoodsPublisher(
        inPoliceForce policeForceID: String) -> AnyPublisher<[NeighbourhoodReference], PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func detailsPublisher(forNeighbourhood id: String,
                          inPoliceForce policeForceID: String) -> AnyPublisher<Neighbourhood, PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func boundaryPublisher(forNeighbourhood neighbourhoodID: String,
                           inPoliceForce policeForceID: String) -> AnyPublisher<[Coordinate], PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID,
                                                                policeForceID: policeForceID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func policeOfficersPublisher(
        forNeighbourhood neighbourhoodID: String,
        inPoliceForce policeForceID: String
    ) -> AnyPublisher<[PoliceOfficer], PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                                      policeForceID: policeForceID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func prioritiesPublisher(
        forNeighbourhood neighbourhoodID: String,
        inPoliceForce policeForceID: String
    ) -> AnyPublisher<[NeighbourhoodPriority], PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID,
                                                                  policeForceID: policeForceID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func neighbourhoodPolicingTeamPublisher(
        atCoordinate coordinate: Coordinate
    ) -> AnyPublisher<NeighbourhoodPolicingTeam, PoliceDataError> {
        apiClient.get(endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate))
    }

}
#endif
