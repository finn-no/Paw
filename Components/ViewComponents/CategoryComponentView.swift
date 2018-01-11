import UIKit

public class CategoryComponentView: UIView {

    // MARK: - Internal properties

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.textColor = .primaryBlue
        label.font = .body
        label.text = "Møbler oginteriør / Sofaer og lenestoler / Sofagrupper"
        label.numberOfLines = 2
        return label
    }()

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
        addSubview(categoryLabel)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }
}

