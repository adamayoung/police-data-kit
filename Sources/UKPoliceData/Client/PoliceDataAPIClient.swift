import Foundation

#if canImport(Combine)
import Combine
#endif

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class PoliceDataAPIClient: APIClient {

    private let baseURL: URL
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    static let shared = PoliceDataAPIClient()

    init(baseURL: URL = .policeDataAPIBaseURL, urlSession: URLSession = URLSession(configuration: .default),
         jsonDecoder: JSONDecoder = .policeDataAPI) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func get<Response: Decodable>(path: URL, completion: @escaping (Result<Response, PoliceDataError>) -> Void) {
        let urlRequest = buildURLRequest(for: path)

        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            if let error = error {
                completion(.failure(.network(error)))
                return
            }

            guard let response = response else {
                completion(.failure(.unknown))
                return
            }

            if let policeDataError = PoliceDataError(response: response) {
                completion(.failure(policeDataError))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(.unknown))
                return
            }

            let decodedResponse: Response
            do {
                decodedResponse = try self.jsonDecoder.decode(Response.self, from: data)
            } catch let error {
                completion(.failure(.decode(error)))
                return
            }

            completion(.success(decodedResponse))
        }
        .resume()
    }

}

#if canImport(Combine)
extension PoliceDataAPIClient {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func get<Response: Decodable>(path: URL) -> AnyPublisher<Response, PoliceDataError> {
        let urlRequest = buildURLRequest(for: path)

        return urlSession.dataTaskPublisher(for: urlRequest)
            .mapPoliceDataError()
            .mapResponse(to: Response.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

}
#endif

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

}

private extension PoliceDataError {

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
