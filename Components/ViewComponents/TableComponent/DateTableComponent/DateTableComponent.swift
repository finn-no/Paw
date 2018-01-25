import Foundation

struct DateTableComponent: TableRowModel {

    let title: String
    let date: Date
    let locale: Locale

    init(title: String, date: Date, locale: Locale) {
        self.title = title
        self.date = date
        self.locale = locale
    }
}
