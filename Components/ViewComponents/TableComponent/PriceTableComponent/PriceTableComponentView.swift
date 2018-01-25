import UIKit

public class PriceTableComponentView: UIView {

    // MARK: - Internal properties

    private let currency = "kroner"     // TODO (UUS): Needs to be injected. This is for voice over accessibility

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = true
        label.font = .title5
        label.textColor = .stone
        label.textAlignment = .right
        return label
    }()

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

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = .smallSpacing
        return stackView
    }()

    // MARK: - External properties

    var component: PriceTableComponent? {
        didSet {
            guard let component = component else {
                return
            }
            priceFormatter.locale = component.locale
            priceFormatter.maximumSignificantDigits = String(component.price).count
            accessibilityPriceFormatter.locale = component.locale
            accessibilityPriceFormatter.maximumSignificantDigits = String(component.price).count
            titleLabel.text = component.title

            if let priceString = priceFormatter.string(from: component.price as NSNumber) {
                detailLabel.text = priceString + ",-"
            }

            if let accessibilityPriceString = accessibilityPriceFormatter.string(from: component.price as NSNumber) {
                accessibilityLabel = component.title + ": " + accessibilityPriceString + currency
            }
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
        addSubview(priceStackView)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: topAnchor),
            priceStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
