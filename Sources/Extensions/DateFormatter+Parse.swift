import Foundation

extension DateFormatter {
    static func parseSimple(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: string)
        if let date {
            return date
        } else {
            fatalError("Couldn't parse string: \"\(string)\"")
        }
    }
}
