import UIKit

protocol IconButtonComponentViewDelegate: class {
    func iconButtonComponentView(_ iconButtonComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent)
}

public class IconButtonComponentView: UIView {

    // MARK: - Internal properties

    private let imageHeight: CGFloat = 20
    private let imageWidth: CGFloat = 20

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.textColor = .primaryBlue
        label.font = .detail
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - External properties

    weak var delegate: IconButtonComponentViewDelegate?

    var component: IconButtonComponent? {
        didSet {
            titleLabel.text = component?.buttonTitle
            iconImageView.image = component?.iconImage
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        addGestureRecognizer(tapGesture)

        addSubview(iconImageView)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -.mediumSpacing),
            iconImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: imageWidth),

            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func buttonAction() {
        guard let component = component, let delegate = delegate else {
            return
        }
        delegate.iconButtonComponentView(self, didTapButtonFor: component)
    }
}
