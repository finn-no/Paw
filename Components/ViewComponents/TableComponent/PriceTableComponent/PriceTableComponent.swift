import Foundation

struct PriceTableComponent: TableComponent {

    let title: String
    let price: Int
    let currency: String

    init(title: String, price: Int, currency: String) {
        self.title = title
        self.price = price
        self.currency = currency
    }
}
