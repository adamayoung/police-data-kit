import Foundation

protocol APIClient {

    func get<Response: Decodable>(path: URL) async throws -> Response

}

extension APIClient {

    func get<Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        try await get(path: endpoint.path)
    }

}

enum APIClientError: Error {

    case network(Error)
    case notFound
    case decode(Error)
    case unknown

}
