//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

class CustomView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .title3
        label.textColor = .licorice
        label.text = "Custom view"
        label.accessibilityLabel = label.text
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .body
        label.textColor = .licorice
        label.text = "This is a custom view"
        label.accessibilityLabel = label.text
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(titleLabel)
        addSubview(detailLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .mediumLargeSpacing),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
