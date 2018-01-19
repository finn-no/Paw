import UIKit

protocol IconButtonComponentViewDelegate: class {
    func iconButtonComponentView(_ iconButtonComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent)
}

public class IconButtonComponentView: UIView {

    // MARK: - Internal properties

    private let imageHeight: CGFloat = 20
    private let imageWidth: CGFloat = 20

    private let highlightedColor = UIColor(red: 0 / 255, green: 79 / 255, blue: 201 / 255, alpha: 1.0) // #004fc9

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
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGesture.minimumPressDuration = 0
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

    @objc func tapHandler(gesture: UITapGestureRecognizer) {
        guard let component = component, let delegate = delegate else {
            return
        }
        if gesture.state == .began {
            titleLabel.textColor = highlightedColor
        }
        if gesture.state == .ended {
            delegate.iconButtonComponentView(self, didTapButtonFor: component)
            titleLabel.textColor = .primaryBlue
        }
    }
}
