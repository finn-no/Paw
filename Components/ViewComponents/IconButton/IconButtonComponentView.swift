import UIKit

protocol AdressComponentViewDelegate: class {
    func adressComponentView(_ adressComponentView: IconButtonComponentView, didSelectComponent component: Component)
}

public class IconButtonComponentView: UIView {

    // MARK: - Internal properties

    weak var delegate: AdressComponentViewDelegate?

    private let pinImage = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)

    private lazy var adressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Hans Nordahls gate 64, 0841 Oslo", for: .normal)
        button.addTarget(self, action: #selector(openMapAction), for: .touchUpInside)
        button.titleLabel?.font = .detail
        button.imageView?.tintColor = .primaryBlue
        button.setImage(pinImage, for: .normal)
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
        addSubview(adressButton)

        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: topAnchor),
            adressButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            adressButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            adressButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func openMapAction(sender: UIButton) {
        guard let component = component else {
            return
        }
        delegate?.adressComponentView(self, didSelectComponent: component)
    }
}
