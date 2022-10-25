import Foundation

extension URLSessionConfiguration {

    static var mock: URLSessionConfiguration {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return config
    }

}
