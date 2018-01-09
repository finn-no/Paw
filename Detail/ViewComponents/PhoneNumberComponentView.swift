import UIKit

protocol PhoneNumberComponentViewDelegate: class {
    func showNumberComponentView(_ showNumberComponentView: PhoneNumberComponentView, didSelectComponent component: Component)
}

public class PhoneNumberComponentView: UIView {

    // MARK: - Internal properties

    private var isNumberShowing: Bool = false

    private lazy var numberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Vis telefonnummer", for: .normal)
        button.addTarget(self, action: #selector(showNumberTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: .mediumSpacing, left: 0, bottom: .mediumSpacing, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.accessibilityLabel = "Vis telefonnummer"
        return button
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .body
        label.text = "Mobil"
        return label
    }()

    // MARK: - External properties

    var component: Component? {
        didSet {
            //            linkLabel.text = component?.id
        }
    }
    weak var delegate: PhoneNumberComponentViewDelegate?

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
        guard let phoneNumber = component?.id else {
            return
        }
        numberButton.setTitle(numberFormat(phoneNumber), for: .normal)
        numberButton.accessibilityLabel = "Telefonnummer: " + phoneNumber
        
        guard let component = component else {
            return
        }
        delegate?.showNumberComponentView(self, didSelectComponent: component)

        if isNumberShowing {
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        isNumberShowing = true
    }

    func numberFormat(_ number: String) -> String {
        if number.count > 8 {
            let landCodeIndex = number.index(number.startIndex, offsetBy: 3)
            let firstIndex = number.index(landCodeIndex, offsetBy: 3)
            let middleIndex = number.index(firstIndex, offsetBy: 2)

            let landCodeString = number.prefix(upTo: landCodeIndex)
            let landCodeAndFirstString = number.prefix(upTo: firstIndex)
            let firstString = landCodeAndFirstString.suffix(from: landCodeIndex)
            let firstAndMiddleString = number.prefix(upTo: middleIndex)
            let middleString = firstAndMiddleString.suffix(from: firstIndex)
            let lastString = number.suffix(from: middleIndex)

            let firstHalfOfString = landCodeString + " " + firstString + " "

            return firstHalfOfString + middleString + " " + lastString
        } else {
            let firstIndex = number.index(number.startIndex, offsetBy: 3)
            let middleIndex = number.index(firstIndex, offsetBy: 2)

            let firstString = number.prefix(upTo: firstIndex)
            let firstAndMiddleString = number.prefix(upTo: middleIndex)
            let middleString = firstAndMiddleString.suffix(from: firstIndex)
            let lastString = number.suffix(from: middleIndex)

            return firstString + " " + middleString + " " + lastString
        }
    }
}

