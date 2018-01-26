import Foundation

struct PriceComponent: Component {

    let id: String
    let price: Double
    let locale: Locale
    let accessibilityPrefix: String
    let status: String?
    let currencyString = "kroner"

    init(id: String = UUID().uuidString, price: Double, locale: Locale, accessibilityPrefix: String, status: String? = nil) {
        self.id = id
        self.price = price
        self.locale = locale
        self.accessibilityPrefix = accessibilityPrefix
        self.status = status
    }

    var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.allowsFloats = false
        return formatter
    }()

    var priceLabel: String? {
        priceFormatter.locale = locale
        priceFormatter.maximumSignificantDigits = String(price).count

        if let priceString = priceFormatter.string(from: price as NSNumber) {
            return priceString + ",-"
        } else {
            return String(price) + ",-"
        }
    }

    var accessibilityLabel: String? {
        if let status = status {
            return accessibilityPrefix + String(price) + currencyString + ". " + status
        } else {
            return accessibilityPrefix + String(price) + currencyString
        }
    }
}
