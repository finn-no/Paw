import Foundation

struct PriceTableComponent: TableRowModel {

    let title: String
    let price: Double
    let locale: Locale

    init(title: String, price: Double, locale: Locale) {
        self.title = title
        self.price = price
        self.locale = locale
    }
}
