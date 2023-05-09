import Foundation

extension String {

    var htmlStripped: String {
        guard let data = data(using: .unicode) else {
            return self
        }

        let attributed = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html
            ],
            documentAttributes: nil
        )

        let value = (attributed?.string ?? self)
            .replacingOccurrences(of: "\n", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        return value
    }

}
