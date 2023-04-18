import Foundation

final class UKNeighbourhoodService: NeighbourhoodService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func neighbourhoods(inPoliceForce policeForceID: String) async throws -> [NeighbourhoodReference] {
        try await apiClient.get(endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID))
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: String) async throws -> Neighbourhood {
        try await apiClient.get(endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID))
    }

    func boundary(forNeighbourhood neighbourhoodID: String,
                  inPoliceForce policeForceID: String) async throws -> [Coordinate] {
        try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        )
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: String,
                        inPoliceForce policeForceID: String) async throws -> [PoliceOfficer] {
        try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                            policeForceID: policeForceID)
            )
    }

    func priorities(forNeighbourhood neighbourhoodID: String,
                    inPoliceForce policeForceID: String) async throws -> [NeighbourhoodPriority] {
        try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        )
    }

    func neighbourhoodPolicingTeam(atCoordinate coordinate: Coordinate) async throws -> NeighbourhoodPolicingTeam {
        try await apiClient.get(endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate))
    }

}
