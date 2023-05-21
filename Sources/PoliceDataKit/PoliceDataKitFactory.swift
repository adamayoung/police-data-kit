import Foundation

final class PoliceDataKitFactory {

    private init() { }

}

extension PoliceDataKitFactory {

    static let apiClient: some APIClient = {
        PoliceDataAPIClient(
            baseURL: policeDataBaseURL,
            urlSession: .shared,
            serialiser: serialiser
        )
    }()

    static var availabilityCache: some AvailabilityCache {
        AvailabilityDefaultCache(cacheStore: cacheStore)
    }

    static var crimeCache: some CrimeCache {
        CrimeDefaultCache(cacheStore: cacheStore)
    }

    static var outcomeCache: some OutcomeCache {
        OutcomeDefaultCache(cacheStore: cacheStore)
    }

    static var policeForceCache: some PoliceForceCache {
        PoliceForceDefaultCache(cacheStore: cacheStore)
    }

}

extension PoliceDataKitFactory {

    static let cacheStore: some Cache = {
        InMemoryCache(name: "PoliceDataKitCache")
    }()

    private static var serialiser: some Serialiser {
        JSONSerialiser(decoder: .policeDataAPI)
    }

}

extension PoliceDataKitFactory {

    private static var policeDataBaseURL: URL {
        URL(string: "https://data.police.uk/api")!
    }

}
