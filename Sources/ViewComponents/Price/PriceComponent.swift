import Foundation

public struct PriceComponent: Component {
    public let id: String
    let price: Double
    let locale: Locale
    let accessibilityPrefix: String
    let status: String?
    let currencyString = "kroner"

    public init(id: String = UUID().uuidString, price: Double, locale: Locale, accessibilityPrefix: String, status: String? = nil) {
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

    var accessibilityPriceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        formatter.maximumFractionDigits = 0
        formatter.groupingSize = 0
        return formatter
    }()

    var priceLabel: String? {
        priceFormatter.locale = locale
        priceFormatter.maximumSignificantDigits = String(price).count

        if let priceString = priceFormatter.string(from: price as NSNumber) {
            return priceString + ",-"
        } else {
            return nil
        }
    }

    var accessibilityLabel: String? {
        guard let accessibilityPriceString = accessibilityPriceFormatter.string(from: price as NSNumber) else {
            return nil
        }

        if let status = status {
            return accessibilityPrefix + accessibilityPriceString + currencyString + ". " + status
        } else {
            return accessibilityPrefix + accessibilityPriceString + currencyString
        }
    }
}
