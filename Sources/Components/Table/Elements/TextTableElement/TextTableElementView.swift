//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class TextTableElementView: UIView {
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
        label.textColor = .stone
        label.textAlignment = .right
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = .smallSpacing
        return stackView
    }()

    var component: TextTableElement? {
        didSet {
            guard let component = component else {
                return
            }
            titleLabel.text = component.title
            detailLabel.text = component.detail
            accessibilityLabel = component.accessibilityLabel
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

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        addGestureRecognizer(longPressGesture)

        isAccessibilityElement = true

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc func longPressed(gesture: UILongPressGestureRecognizer) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            let titleLabelWidth = titleLabel.bounds.width
            let detailLabelWidth = detailLabel.bounds.width
            let labelRect = CGRect(x: titleLabelWidth + detailLabelWidth / 2, y: 0, width: detailLabelWidth / 2, height: bounds.height)
            menu.setTargetRect(labelRect, in: self)
            print(labelRect)
            menu.setMenuVisible(true, animated: true)
        }
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }

    public override func copy(_ sender: Any?) {
        guard let detailString = detailLabel.text else {
            return
        }

        let board = UIPasteboard.general
        board.string = detailString
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }
}
