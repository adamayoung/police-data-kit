import Foundation

public protocol FetchAvailableDataSetsUseCase {

    func execute() async throws -> [DataSet]

}
