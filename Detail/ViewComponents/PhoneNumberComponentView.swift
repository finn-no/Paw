import UIKit

protocol PhoneNumberComponentViewDelegate: class {
    func showNumberComponentView(_ showNumberComponentView: PhoneNumberComponentView, didSelectComponent component: Component)
}

public class PhoneNumberComponentView: UIView {

    // MARK: - Internal properties


    private lazy var numberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Vis telefonnummer", for: .normal)
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
        showNumberButton.setTitle("123 45 678", for: .normal)
        
        guard let component = component else {
            return
        }
        delegate?.showNumberComponentView(self, didSelectComponent: component)
    }
}

