import Foundation

protocol AvailabilityRepository {

    func availableDataSets() async throws -> [DataSet]

}
