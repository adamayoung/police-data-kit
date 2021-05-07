import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about a Police Force Neighbourhoods.
public protocol NeighbourhoodService {

    func fetchAll(inPoliceForce policeForceID: String,
                  completion: @escaping (_ result: Result<[NeighbourhoodReference], PoliceDataError>) -> Void)

    func fetchDetails(forNeighbourhood id: String, inPoliceForce policeForceID: String,
                      completion: @escaping (_ result: Result<Neighbourhood, PoliceDataError>) -> Void)

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func neighbourhoodsPublisher(
        inPoliceForce policeForceID: String) -> AnyPublisher<[NeighbourhoodReference], PoliceDataError>

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func detailsPublisher(forNeighbourhood id: String,
                          inPoliceForce policeForceID: String) -> AnyPublisher<Neighbourhood, PoliceDataError>

    #endif

}
