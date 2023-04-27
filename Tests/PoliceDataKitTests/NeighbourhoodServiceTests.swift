@testable import PoliceDataKit
import XCTest

final class NeighbourhoodServiceTests: XCTestCase {

    var service: NeighbourhoodService!
    var neighbourhoodRepository: MockNeighbourhoodRepository!

    override func setUp() {
        super.setUp()
        neighbourhoodRepository = MockNeighbourhoodRepository()
        service = NeighbourhoodService(neighbourhoodRepository: neighbourhoodRepository)
    }

    override func tearDown() {
        neighbourhoodRepository = nil
        service = nil
        super.tearDown()
    }

}
