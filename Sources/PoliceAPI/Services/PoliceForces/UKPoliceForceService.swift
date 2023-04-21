import Foundation

final class UKPoliceForceService: PoliceForceService {

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func policeForces() async throws -> [PoliceForceReference] {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.list)
    }

    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        try await apiClient.get(endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID))
    }

}
