import UIKit

public class PriceComponentView: UIView {

    // MARK: - Internal properties

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .title1
        label.textColor = .licorice
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .title1
        label.textColor = .licorice
        return label
    }()

    // MARK: - External properties

    var component: PriceComponent? {
        didSet {
            guard let component = component else {
                return
            }

            priceLabel.text = component.priceLabel
            accessibilityLabel = component.accessibilityLabel
            statusLabel.text = component.status

            let statusIsEmpty = component.status?.isEmpty ?? false
            if statusIsEmpty {
                priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
            } else {
                addSubview(statusLabel)

                NSLayoutConstraint.activate([
                    statusLabel.topAnchor.constraint(equalTo: topAnchor),
                    statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                    statusLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceLabel.trailingAnchor, constant: .mediumLargeSpacing),
                    statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                    ])
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
        addSubview(priceLabel)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
