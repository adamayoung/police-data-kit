@testable import PoliceDataKit
import XCTest

final class PoliceForceServiceTests: XCTestCase {

    var service: PoliceForceService!
    var policeForceRepository: MockPoliceForceRepository!

    override func setUp() {
        super.setUp()
        policeForceRepository = MockPoliceForceRepository()
        service = PoliceForceService(policeForceRepository: policeForceRepository)
    }

    override func tearDown() {
        policeForceRepository = nil
        service = nil
        super.tearDown()
    }

}
