import Foundation

final actor PoliceDataAPIClient: APIClient {

    private let baseURL: URL
    private let urlSession: URLSession
    private let serialiser: Serialiser

    init(baseURL: URL, urlSession: URLSession, serialiser: Serialiser) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.serialiser = serialiser
    }

    func get<Response: Decodable>(path: URL) async throws -> Response {
        let urlRequest = buildURLRequest(for: path)

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch let error {
            throw APIClientError.network(error)
        }

        try validate(response: response)
        let result: Response
        do {
            result = try await serialiser.decode(Response.self, from: data)
        } catch let error {
            throw APIClientError.decode(error)
        }

        return result
    }

}

extension PoliceDataAPIClient {

    private func buildURLRequest(for path: URL) -> URLRequest {
        let url = urlFromPath(path)
        var urlRequest = URLRequest(url: url)

        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        return urlRequest
    }

    private func urlFromPath(_ path: URL) -> URL {
        guard var urlComponents = URLComponents(url: path, resolvingAgainstBaseURL: true) else {
            return path
        }

        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path + "\(urlComponents.path)"

        return urlComponents.url!
    }

    private func validate(response: URLResponse) throws {
        if let error = APIClientError(response: response) {
            throw error
        }
    }

}

private extension APIClientError {

    init?(response: URLResponse) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        guard statusCode != 200 else {
            return nil
        }

        if statusCode == 404 {
            self = .notFound
            return
        }

        self = .unknown
    }

}
