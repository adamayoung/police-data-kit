import Foundation
import SwiftSoup

extension String {

    var htmlStripped: String {
        guard let document = try? SwiftSoup.parse(self) else {
            return ""
        }

        guard let text = try? document.text() else {
            return ""
        }

        return text
    }

}
