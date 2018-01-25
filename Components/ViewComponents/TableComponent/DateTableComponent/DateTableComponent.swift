import Foundation

struct DateTableComponent: TableRowModel {

    let title: String
    let locale: Locale
    let date: Date
    let dateFormat: DateFormat

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


    init(title: String, date: Date, locale: Locale, dateFormat: DateFormat) {
        self.title = title
        self.date = date
        self.locale = locale
        self.dateFormat = dateFormat
    }
}
