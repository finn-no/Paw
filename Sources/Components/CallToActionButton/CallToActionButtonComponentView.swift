//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

protocol CallToActionButtonComponentViewDelegate: class {
    func callToActionButtonComponentView(_ callToActionButtonComponentView: CallToActionButtonComponentView, didTapSendMessageFor component: CallToActionButtonComponent)
}

public class CallToActionButtonComponentView: UIView {
    weak var delegate: CallToActionButtonComponentViewDelegate?
    private let highlightedColor = UIColor(red: 0 / 255, green: 79 / 255, blue: 201 / 255, alpha: 1.0) // #004fc9
    private let cornerRadius: CGFloat = 4.0

    private lazy var callToActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .title4
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .primaryBlue
        button.layer.cornerRadius = cornerRadius
        button.addTarget(self, action: #selector(messageTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        return button
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        return label
    }()

    var component: CallToActionButtonComponent? {
        didSet {
            callToActionButton.setTitle(component?.title, for: .normal)
            subtitleLabel.text = component?.subtitle
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
        addSubview(callToActionButton)
        addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: topAnchor),
            callToActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            callToActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),

            subtitleLabel.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: .mediumSpacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc func messageTapped(sender: UIButton) {
        sender.backgroundColor = .primaryBlue

        guard let component = component else {
            return
        }
        delegate?.callToActionButtonComponentView(self, didTapSendMessageFor: component)
    }

    @objc func buttonHighlighted(sender: UIButton) {
        sender.backgroundColor = highlightedColor
    }
}
