import Foundation

struct PriceComponent: Component {

    let id: String
    let price: Int
    let locale: Locale
    let accessibilityPrefix: String

    init(id: String = UUID().uuidString, price: Int, locale: Locale, accessibilityPrefix: String) {
        self.id = id
        self.price = price
        self.locale = locale
        self.accessibilityPrefix = accessibilityPrefix
    }
}
