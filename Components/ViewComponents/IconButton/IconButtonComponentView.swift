import UIKit

protocol IconButtonComponentViewDelegate: class {
    func iconButtonComponentView(_ iconButtonComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent)
}

public class IconButtonComponentView: UIView {

    // MARK: - Internal properties

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.titleLabel?.font = .detail
        button.imageView?.tintColor = .primaryBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -.smallSpacing, bottom: 0, right: .smallSpacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: .smallSpacing, bottom: 0, right: -.smallSpacing)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: .smallSpacing, bottom: 0, right: .smallSpacing)
        return button
    }()

    // MARK: - External properties

    weak var delegate: IconButtonComponentViewDelegate?

    var component: IconButtonComponent? {
        didSet {
            button.setTitle(component?.buttonTitle, for: .normal)        // "Hans Nordahls gate 64, 0841 Oslo" / "Få hjelp til frakt"
            button.setImage(component?.iconImage, for: .normal)          // pinImage or little van
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
        addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func buttonAction(sender: UIButton) {
        guard let component = component, let delegate = delegate else {
            return
        }
        delegate.iconButtonComponentView(self, didTapButtonFor: component)
    }
}
