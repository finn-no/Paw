//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class TitleComponentView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .title2
        label.textColor = .licorice
        label.numberOfLines = 0
        return label
    }()

    var component: TitleComponent? {
        didSet {
            guard let component = component else {
                return
            }

            label.text = component.text
            accessibilityLabel = component.text
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
        addSubview(label)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .mediumLargeSpacing),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.mediumLargeSpacing),
        ])
    }
}
