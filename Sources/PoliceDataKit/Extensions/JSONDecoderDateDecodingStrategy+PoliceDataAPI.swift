import Foundation

extension JSONDecoder.DateDecodingStrategy {

    static var policeDataAPI: JSONDecoder.DateDecodingStrategy {
        .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            if let date = DateFormatter.dateTime.date(from: string) {
                return date
            }

            if let date = DateFormatter.dateTimeWithTimeZoneOffset.date(from: string) {
                return date
            }

            if let date = DateFormatter.yearMonth.date(from: string) {
                return date
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date is in invalid format")
        }
    }

}
