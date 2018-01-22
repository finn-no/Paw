import Foundation

struct PriceComponent: Component {

    let id: String
    let price: Int
    let currency: String
    let accessibilityPrefix: String

    init(id: String = UUID().uuidString, price: Int, currency: String, accessibilityPrefix: String) {
        self.id = id
        self.price = price
        self.currency = currency
        self.accessibilityPrefix = accessibilityPrefix
    }
}
