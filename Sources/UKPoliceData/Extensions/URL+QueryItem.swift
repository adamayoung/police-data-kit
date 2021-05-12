import Foundation

extension URL {

    func appendingQueryItem(name: String, value: CustomStringConvertible) -> Self {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value.description))
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }

    func appendingQueryItem(name: String, value: Date?, formatter: DateFormatter = .yearMonth) -> Self {
        guard let date = value else {
            return self
        }

        let dateString = formatter.string(from: date)
        return appendingQueryItem(name: name, value: dateString)
    }

    func appendingQueryItem(name: String, value: Coordinate) -> Self {
        appendingQueryItem(name: name, value: "\(value.latitude),\(value.longitude)")
    }

    func appendingQueryItem(name: String, value: [Coordinate]) -> Self {
        let pairs = value.map { "\($0.latitude),\($0.longitude)" }
        return appendingQueryItem(name: name, value: pairs.joined(separator: ":"))
    }

}
