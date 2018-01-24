import UIKit

public class PriceComponentView: UIView {

    // MARK: - Internal properties

    let currencyString = "kroner"

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .title1
        label.textColor = .licorice
        return label
    }()

    var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.allowsFloats = false
        return formatter
    }()

    // MARK: - External properties

    var component: PriceComponent? {
        didSet {
            guard let component = component else {
                return
            }
            priceFormatter.locale = component.locale
            priceFormatter.maximumSignificantDigits = String(component.price).count
            priceLabel.text = priceFormatter.string(from: component.price as NSNumber)! + ",-"
            priceLabel.accessibilityLabel = component.accessibilityPrefix + String(component.price) + currencyString
        }
    }

    // MARK: - Setup

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
