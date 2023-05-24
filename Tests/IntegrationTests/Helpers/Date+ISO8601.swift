import Foundation

extension Date {

    init?(isoString: String) {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else {
            return nil
        }

        self = date
    }

}
