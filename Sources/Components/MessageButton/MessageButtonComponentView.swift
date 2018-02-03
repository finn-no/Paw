import UIKit

protocol MessageComponentViewDelegate: class {
    func messageComponentView(_ messageComponentView: MessageButtonComponentView, didTapSendMessageFor component: MessageButtonComponent)
}

public class MessageButtonComponentView: UIView {

    // MARK: - Internal properties

    weak var delegate: MessageComponentViewDelegate?
    private let highlightedColor = UIColor(red: 0 / 255, green: 79 / 255, blue: 201 / 255, alpha: 1.0) // #004fc9
    private let cornerRadius: CGFloat = 4.0

    private lazy var messageButton: UIButton = {
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

    private lazy var answerTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        return label
    }()

    // MARK: - External properties

    var component: MessageButtonComponent? {
        didSet {
            messageButton.setTitle(component?.title, for: .normal)
            answerTimeLabel.text = component?.answerTime
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
        addSubview(messageButton)
        addSubview(answerTimeLabel)

        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: topAnchor),
            messageButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageButton.trailingAnchor.constraint(equalTo: trailingAnchor),

            answerTimeLabel.topAnchor.constraint(equalTo: messageButton.bottomAnchor, constant: .mediumSpacing),
            answerTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            answerTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            answerTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc func messageTapped(sender: UIButton) {
        sender.backgroundColor = .primaryBlue

        guard let component = component else {
            return
        }
        delegate?.messageComponentView(self, didTapSendMessageFor: component)
    }

    @objc func buttonHighlighted(sender: UIButton) {
        sender.backgroundColor = highlightedColor
    }
}
