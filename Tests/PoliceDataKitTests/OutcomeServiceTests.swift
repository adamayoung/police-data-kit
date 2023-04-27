@testable import PoliceDataKit
import XCTest

final class OutcomeServiceTests: XCTestCase {

    var service: OutcomeService!
    var outcomeRepository: MockOutcomeRepository!

    override func setUp() {
        super.setUp()
        outcomeRepository = MockOutcomeRepository()
        service = OutcomeService(outcomeRepository: outcomeRepository)
    }

    override func tearDown() {
        outcomeRepository = nil
        service = nil
        super.tearDown()
    }

}
