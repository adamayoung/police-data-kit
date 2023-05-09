@testable import PoliceDataKit
import XCTest

final class StringHTMLTests: XCTestCase {

    func testHTMLStrippedWhenNoHTMLReturnsSelf() {
        let value = "Hello, this is the PoliceDataKit."

        let result = value.htmlStripped

        XCTAssertEqual(result, value)
    }

    func testHTMLStrippedWhenContainsSimpleHTMLTagReturnsSelfWithoutHTML() {
        let value = "Hello, this is the <b>PoliceDataKit</b>."
        let expectedResult = "Hello, this is the PoliceDataKit."

        let result = value.htmlStripped

        XCTAssertEqual(result, expectedResult)
    }

    func testHTMLStrippedWhenContainsHTMLTagReturnsSelfWithoutHTML() {
        let value = "<p>The Castle neighbourhood is a diverse covering all of the City Centre. In addition it covers "
        + "De Montfort University, the University of Leicester, Leicester Royal Infirmary, the Leicester Tigers "
        + "rugby ground and the Clarendon Park and Riverside communities.</p>\n<p>The Highcross and Haymarket "
        + "shopping centres and Leicester's famous Market are all covered by this neighbourhood.</p>"
        let expectedResult = "The Castle neighbourhood is a diverse covering all of the City Centre. In addition it "
        + "covers De Montfort University, the University of Leicester, Leicester Royal Infirmary, the Leicester Tigers "
        + "rugby ground and the Clarendon Park and Riverside communities. The Highcross and Haymarket shopping "
        + "centres and Leicester's famous Market are all covered by this neighbourhood."

        let result = value.htmlStripped

        XCTAssertEqual(result, expectedResult)
    }

    func testHTMLStrippedWhenEmptyStringReturnsEmptyString() {
        let value = ""

        let result = value.htmlStripped

        XCTAssertEqual(result, "")
    }

}
