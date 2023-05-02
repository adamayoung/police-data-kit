@testable import PoliceDataKit
import XCTest

final class StopAndSearchServiceTests: XCTestCase {

    var service: StopAndSearchService!
    var stopAndSearchRepository: MockStopAndSearchRepository!

    override func setUp() {
        super.setUp()
        stopAndSearchRepository = MockStopAndSearchRepository()
        service = StopAndSearchService(stopAndSearchRepository: stopAndSearchRepository)
    }

    override func tearDown() {
        stopAndSearchRepository = nil
        service = nil
        super.tearDown()
    }

}
