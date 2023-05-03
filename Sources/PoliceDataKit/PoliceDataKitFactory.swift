import Foundation

final class PoliceDataKitFactory {

    private init() { }

    static let apiClient: some APIClient = {
        PoliceDataAPIClient(
            baseURL: policeDataBaseURL,
            urlSession: .shared,
            serialiser: serialiser
        )
    }()

    private static var serialiser: some Serialiser {
        JSONSerialiser(decoder: .policeDataAPI)
    }

    static let cache: some Cache = {
        InMemoryCache(name: "PoliceDataKitCache")
    }()

}

extension PoliceDataKitFactory {

    private static var policeDataBaseURL: URL {
        URL(string: "https://data.police.uk/api")!
    }

}
