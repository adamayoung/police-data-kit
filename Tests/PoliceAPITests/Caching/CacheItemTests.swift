@testable import PoliceAPI
import XCTest

final class CacheItemTests: XCTestCase {

    func testIsExpiredWhenNoExpiresInSetReturnsFalse() {
        let item = CacheItem(key: "key1", object: "object1")

        XCTAssertFalse(item.isExpired)
    }

    func testIsExpiredWhenNotExpiredReturnsFalse() {
        let item = CacheItem(key: "key2", object: "object3", expiresIn: 10)

        XCTAssertFalse(item.isExpired)
    }

    func testIsExpiredWhenExpiredReturnsTrue() {
        let item = CacheItem(key: "key3", object: "object3", expiresIn: -10)

        XCTAssertTrue(item.isExpired)
    }

}
