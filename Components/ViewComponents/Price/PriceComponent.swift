import Foundation

struct PriceComponent: Component {

    let id: String
    let price: Double
    let locale: Locale
    let accessibilityPrefix: String
    let status: String?

    init(id: String = UUID().uuidString, price: Double, locale: Locale, accessibilityPrefix: String, status: String? = nil) {
        self.id = id
        self.price = price
        self.locale = locale
        self.accessibilityPrefix = accessibilityPrefix
        self.status = status
    }
}
