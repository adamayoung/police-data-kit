import Foundation

#if canImport(Combine)
import Combine
#endif

protocol APIClient {

    func get<Response: Decodable>(path: URL, completion: @escaping (Result<Response, PoliceDataError>) -> Void)

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(path: URL) -> AnyPublisher<Response, PoliceDataError>
    #endif

}

extension APIClient {

    func get<Response: Decodable>(endpoint: Endpoint,
                                  completion: @escaping (Result<Response, PoliceDataError>) -> Void) {
        get(path: endpoint.url, completion: completion)
    }

}

#if canImport(Combine)
extension APIClient {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(endpoint: Endpoint) -> AnyPublisher<Response, PoliceDataError> {
        get(path: endpoint.url)
    }

}
#endif
