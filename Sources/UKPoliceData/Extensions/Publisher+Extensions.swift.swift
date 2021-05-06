#if canImport(Combine)
import Combine
import Foundation

extension URLSession.DataTaskPublisher {

    func mapPoliceDataError() -> AnyPublisher<Output, PoliceDataError> {
        self
            .mapError { .network($0) }
            .flatMap { (data, response) -> AnyPublisher<Output, PoliceDataError> in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                guard statusCode != 200 else {
                    return Just((data, response))
                        .setFailureType(to: PoliceDataError.self)
                        .eraseToAnyPublisher()
                }

                let error: PoliceDataError = {
                    switch statusCode {
                    case 404:
                        return .notFound

                    default:
                        return .unknown
                    }
                }()

                return Fail(outputType: Output.self, failure: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {

    func mapResponse<Output: Decodable>(to outputType: Output.Type,
                                        decoder: JSONDecoder) -> AnyPublisher<Output, PoliceDataError> {
        self
            .map { $0.data }
            .decode(type: outputType, decoder: decoder)
            .mapError {
                .decode($0)
            }
            .eraseToAnyPublisher()
    }

}
#endif
