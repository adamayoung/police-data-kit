import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKPoliceForceService: PoliceForceService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchAll(completion: @escaping (Result<[PoliceForceReference], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: PoliceForcesEndpoint.list, completion: completion)
    }

    func fetchDetails(forPoliceForce id: String, completion: @escaping (Result<PoliceForce, PoliceDataError>) -> Void) {
        apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id), completion: completion)
    }

    func fetchSeniorOfficers(forPoliceForce policeForceID: String,
                             completion: @escaping (Result<[PoliceOfficer], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID),
                      completion: completion)
    }

}

#if canImport(Combine)
extension UKPoliceForceService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func policeForcesPublisher() -> AnyPublisher<[PoliceForceReference], PoliceDataError> {
        apiClient.get(endpoint: PoliceForcesEndpoint.list)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func detailsPublisher(forPoliceForce id: String) -> AnyPublisher<PoliceForce, PoliceDataError> {
        apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func seniorOfficersPublisher(
        forPoliceForce policeForceID: String
    ) -> AnyPublisher<[PoliceOfficer], PoliceDataError> {
        apiClient.get(endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID))
    }

}
#endif
