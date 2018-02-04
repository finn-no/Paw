//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

protocol LinkComponentViewDelegate: class {
    func linkComponentView(_ linkComponentView: LinkComponentView, didTapButtonFor component: LinkComponent)
}

public class LinkComponentView: UIView {
    private let imageHeight: CGFloat = 20
    private let imageWidth: CGFloat = 20

    private let highlightedColor = UIColor(red: 0 / 255, green: 79 / 255, blue: 201 / 255, alpha: 1.0) // #004fc9

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .detail
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
        return button
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    weak var delegate: LinkComponentViewDelegate?

    var component: LinkComponent? {
        didSet {
            button.setTitle(component?.title, for: .normal)
            accessibilityLabel = component?.title

            iconImageView.image = component?.iconImage ?? nil
            iconImageView.isHidden = (component?.iconImage == nil)

            if let _ = component?.iconImage {
                NSLayoutConstraint.activate([
                    iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
                    iconImageView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -.mediumSpacing),

                    button.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.mediumLargeSpacing),
                ])
            } else {
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing).isActive = false
                iconImageView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -.mediumSpacing).isActive = false

                NSLayoutConstraint.activate([
                    button.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: .mediumLargeSpacing),
                ])
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isAccessibilityElement = true
        accessibilityTraits = UIAccessibilityTraitButton

        addSubview(iconImageView)
        addSubview(button)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: imageWidth),

            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc func tapHandler(gesture: UITapGestureRecognizer) {
        guard let component = component, let delegate = delegate else {
            return
        }
        delegate.linkComponentView(self, didTapButtonFor: component)
    }
}
