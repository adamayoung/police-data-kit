import Foundation

protocol AvailabilityCache {

    func availableDataSets() async -> [DataSet]?

    func setAvailableDataSets(_ dataSets: [DataSet]) async

}
