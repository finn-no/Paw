import Foundation

struct DateTableComponent: TableElement {

    var dateFormatter = DateFormatter()

    let title: String
    let locale: Locale
    let timeZone: TimeZone
    let date: Date
    let dateFormat: DateFormat?

    enum DateFormat {
        case year
        case dateAndTime
        case date
        case time

        var dateStyle: DateFormatter.Style {
            switch self {
            case .dateAndTime:
                return .medium
            case .date:
                return .full
            case .time:
                return .none
            case .year:
                return .short
            }
        }
        var timeStyle: DateFormatter.Style {
            switch self {
            case .dateAndTime:
                return .short
            case .date:
                return .none
            case .time:
                return .long
            case .year:
                return .none
            }
        }
    }


    init(title: String, date: Date, locale: Locale = .autoupdatingCurrent, timeZone: TimeZone = .autoupdatingCurrent, dateFormat: DateFormat? = .dateAndTime) {
        self.title = title
        self.date = date
        self.locale = locale
        self.timeZone = timeZone
        self.dateFormat = dateFormat
    }

    var dateLabel: String {
        dateFormatter.locale = locale

        if dateFormat == .year {
            dateFormatter.dateFormat = "yyyy"
        } else {
            guard let dateStyle = dateFormat?.dateStyle, let timeStyle = dateFormat?.timeStyle else {
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                return dateFormatter.string(from: date)
            }
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            dateFormatter.timeZone = timeZone
        }

        return dateFormatter.string(from: date)
    }

    var accessibilityLabel: String {
        return title + ": " + dateLabel
    }
}
