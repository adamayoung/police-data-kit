import Foundation

#if canImport(Combine)
import Combine
#endif

protocol APIClient {

    func get<Response: Decodable>(path: URL, httpHeaders: [String: String]?,
                                  completion: @escaping (Result<Response, PoliceDataError>) -> Void)

    #if canImport(Combine)
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(path: URL, httpHeaders: [String: String]?) -> AnyPublisher<Response, PoliceDataError>
    #endif

}

extension APIClient {

    func get<Response: Decodable>(path: URL, httpHeaders: [String: String]? = nil,
                                  completion: @escaping (Result<Response, PoliceDataError>) -> Void) {
        get(path: path, httpHeaders: httpHeaders, completion: completion)
    }

    func get<Response: Decodable>(endpoint: Endpoint, httpHeaders: [String: String]? = nil,
                                  completion: @escaping (Result<Response, PoliceDataError>) -> Void) {
        get(path: endpoint.url, httpHeaders: httpHeaders, completion: completion)
    }

}

#if canImport(Combine)
extension APIClient {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(path: URL,
                                  httpHeaders: [String: String]? = nil) -> AnyPublisher<Response, PoliceDataError> {
        get(path: path, httpHeaders: httpHeaders)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(endpoint: Endpoint,
                                  httpHeaders: [String: String]? = nil) -> AnyPublisher<Response, PoliceDataError> {
        get(path: endpoint.url, httpHeaders: httpHeaders)
    }

}
#endif
