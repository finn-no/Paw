import UIKit

public class DateTableComponentView: UIView {

    // MARK: - Internal properties

    private var dateFormatter = DateFormatter()

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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = .smallSpacing
        return stackView
    }()

    // MARK: - External properties

    var component: DateTableComponent? {
        didSet {
            guard let component = component else {
                return
            }
            dateFormatter.locale = component.locale

            if component.dateFormat == .year {
                dateFormatter.dateFormat = "yyyy"
            } else {
                guard let dateStyle = component.dateFormat?.dateStyle, let timeStyle = component.dateFormat?.timeStyle else {
                    return
                }
                dateFormatter.dateStyle = dateStyle
                dateFormatter.timeStyle = timeStyle
            }

            titleLabel.text = component.title
            detailLabel.text = dateFormatter.string(from: component.date)
            accessibilityLabel = component.title + ": " + dateFormatter.string(from: component.date)
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
        addSubview(stackView)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
