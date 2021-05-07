import Foundation

#if !os(Linux)
final class URLProtocolMock: URLProtocol {

    static var responseConfigs = [URL?: (HTTPURLResponse?, Data?)]()
    static var requests = [URLRequest]()

    class func reset() {
        responseConfigs = [:]
        requests = []
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }

        guard let url = request.url else {
            return
        }

        guard let responseConfig = URLProtocolMock.responseConfigs[url] else {
            let error = URLError(.unsupportedURL)
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let response = responseConfig.0 {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let data = responseConfig.1 {
            client?.urlProtocol(self, didLoad: data)
        }
    }

    override func stopLoading() { }

}
#endif
