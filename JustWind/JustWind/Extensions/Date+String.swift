import UIKit

extension Date {
    
    func toString(formatString: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: self)
    }
    
    func toString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func toDate(formatString: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter.date(from: self)
    }
    
    func formattedDateString(formatter: String,
                             dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss") -> String? {
        guard let date = self.toDate() else { return nil }
        return date.toString(formatString: formatter)
    }
}
