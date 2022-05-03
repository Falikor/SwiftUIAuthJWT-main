import Foundation

//Date formates
extension Date {
    public static let dateAndTimeZulu = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    public static let dateAndTimeWithZone = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
    public static let date = "yyyy-MM-dd"
    public static let sapDate = "yyyyMMdd"
    public static let dayAndMonth = "dd.MM"
}

extension Date {
    
    // Example: 20200612
    public static func sapDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.sapDate
        return dateFormatter.date(from: string)
    }

    // Example: 20200612
    public func sapStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.sapDate
        return dateFormatter.string(from: self)
    }
    
    // Example: 30.08
    public func dayMonthWithDots() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.dayAndMonth
        return dateFormatter.string(from: self)
    }
    
    // Example: 30.08.2019
    public func dayMonthYearWithDots() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }

    // Example: 30.08.19
    public func dayMonthShortYearWithDots() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: self)
    }

    // Example: 08 nov 2019 16:00
    public func dayMonthHoursAsStringYearWithSpaces() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy H:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU") // TODO: remove hardcoded locale
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    // Example: 1970-12-18
    public func jsonDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.date
        return dateFormatter.string(from: self)
    }
    
    func isBefore(_ date: Date = Date()) -> Bool {

        let calendar = Calendar.current

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)

        return calendar.date(from: selfComponents)! < calendar.date(from: dateComponents)!
    }
}
