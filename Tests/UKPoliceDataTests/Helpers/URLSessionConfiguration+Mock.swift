import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSessionConfiguration {

    static var mock: URLSessionConfiguration {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return config
    }

}
