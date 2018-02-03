import UIKit

protocol PhoneNumberComponentViewDelegate: class {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool
}

public class PhoneNumberComponentView: UIView {

    // MARK: - Internal properties

    private var isNumberShowing: Bool = false

    private lazy var numberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(showNumberTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: .mediumSpacing, left: 0, bottom: .mediumSpacing, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .body
        return label
    }()

    // MARK: - External properties

    weak var delegate: PhoneNumberComponentViewDelegate?
    var component: PhoneNumberComponent? {
        didSet {
            numberButton.setTitle(component?.showNumberText, for: .normal) // "Vis telefonnummer"
            numberButton.accessibilityLabel = component?.showNumberText
            descriptionLabel.text = component?.descriptionText // "Mobil"
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
        addSubview(numberButton)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: numberButton.leadingAnchor, constant: -.mediumLargeSpacing),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            numberButton.topAnchor.constraint(equalTo: topAnchor),
            numberButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            numberButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc func showNumberTapped(sender: UIButton) {
        guard let component = component, let delegate = delegate else {
            return
        }
        let canShowPhoneNumber = delegate.phoneNumberComponentView(self, canShowPhoneNumberFor: component)
        guard canShowPhoneNumber else {
            return
        }
        if isNumberShowing {
            delegate.phoneNumberComponentView(self, didTapPhoneNumberFor: component)
        } else {
            numberButton.setTitle(component.formattedPhoneNumber, for: .normal)
            numberButton.accessibilityLabel = component.accessibilityLabelPrefix + component.phoneNumber
            isNumberShowing = true
        }
    }
}
