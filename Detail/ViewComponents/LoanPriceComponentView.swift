import UIKit

protocol LoanPriceComponentViewDelegate: class {
    func loanPriceComponentView(_ loanPriceComponentView: LoanPriceComponentView, didSelectComponent component: Component)
}

public class LoanPriceComponentView: UIView {

    // MARK: - Internal properties

    weak var delegate: LoanPriceComponentViewDelegate?

    private lazy var loanPriceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Pris på lån", for: .normal)
        button.addTarget(self, action: #selector(loanPriceTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = .detail
        return button
    }()

    // MARK: - External properties

    var component: Component? {
        didSet {
            //            linkLabel.text = component?.id
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
        addSubview(loanPriceButton)

        NSLayoutConstraint.activate([
            loanPriceButton.topAnchor.constraint(equalTo: topAnchor),
            loanPriceButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            loanPriceButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            loanPriceButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func loanPriceTapped(sender: UIButton) {
        guard let component = component else {
            return
        }
        delegate?.loanPriceComponentView(self, didSelectComponent: component)
    }
}
