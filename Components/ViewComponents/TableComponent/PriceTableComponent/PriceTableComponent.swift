import Foundation

struct PriceTableComponent: TableComponent {

    let title: String
    let price: Int

    init(title: String, price: Int) {
        self.title = title
        self.price = price
    }
}
