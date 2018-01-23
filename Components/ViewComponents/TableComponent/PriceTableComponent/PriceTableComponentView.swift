import UIKit

public class PriceTableComponentView: UIView {

    // MARK: - Internal properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .body
        label.textColor = .stone
        return label
    }()

    var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.allowsFloats = false
        formatter.groupingSize = 3
        formatter.groupingSeparator = " "
        return formatter
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = .smallSpacing
        return stackView
    }()

    // MARK: - External properties

    var component: PriceTableComponent? {
        didSet {
            guard let component = component else {
                return
            }
            titleLabel.text = component.title
            detailLabel.text = priceFormatter.string(from: component.price as NSNumber)! + ",-"
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

        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: topAnchor),
            priceStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
