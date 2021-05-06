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

}
#endif
