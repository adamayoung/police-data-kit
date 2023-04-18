import Foundation

final class UKPoliceForceService: PoliceForceService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func policeForces() async throws -> [PoliceForceReference] {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.list)
    }

    func policeForce(withID id: String) async throws -> PoliceForce {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
    }

    func seniorOfficers(inPoliceForce policeForceID: String) async throws -> [PoliceOfficer] {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID))
    }

}
