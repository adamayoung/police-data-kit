import Foundation

extension URL {

    func appendingQueryItem(name: String, value: CustomStringConvertible) -> Self {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value.description))
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }

    func appendingQueryItem(name: String, date: Date?, formatter: DateFormatter = .yearMonth) -> Self {
        guard let date = date else {
            return self
        }

        let dateString = formatter.string(from: date)
        return appendingQueryItem(name: name, value: dateString)
    }

    func appendingQueryItem(name: String, coordinate: Coordinate) -> Self {
        appendingQueryItem(name: name, value: "\(coordinate.latitude),\(coordinate.longitude)")
    }

    func appendingQueryItem(name: String, coordinates: [Coordinate]) -> Self {
        let pairs = coordinates
            .map { "\($0.latitude),\($0.longitude)" }
            .joined(separator: ":")
        return appendingQueryItem(name: name, value: pairs)
    }

}
