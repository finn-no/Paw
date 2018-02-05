//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

protocol PhoneNumberListComponentViewDelegate: class {
    func phoneNumberListComponentView(_ phoneNumberListComponentView: PhoneNumberListComponentView, didTapPhoneNumberFor component: PhoneNumberListComponent)
}

public class PhoneNumberListComponentView: UIView {
    weak var delegate: PhoneNumberListComponentViewDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = true
        label.font = .title5
        label.textColor = .primaryBlue
        label.textAlignment = .right
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = .smallSpacing
        stackView.isUserInteractionEnabled = true
        return stackView
    }()

    var component: PhoneNumberListComponent? {
        didSet {
            guard let component = component else {
                return
            }

            titleLabel.text = component.title
            detailLabel.text = component.formattedPhoneNumber
            accessibilityLabel = component.formattedPhoneNumber
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
        addSubview(stackView)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailLabelTapped))
        stackView.addGestureRecognizer(tapGesture)
    }

    @objc func detailLabelTapped() {
        guard let component = component else {
            return
        }

        delegate?.phoneNumberListComponentView(self, didTapPhoneNumberFor: component)
    }
}
