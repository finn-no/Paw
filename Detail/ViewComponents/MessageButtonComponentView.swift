import UIKit

protocol MessageComponentViewDelegate: class {
    func messageComponentView(_ messageComponentView: MessageButtonComponentView, didSelectComponent component: Component)
}

public class MessageButtonComponentView: UIView {

    // MARK: - Internal properties

    weak var delegate: MessageComponentViewDelegate?

    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .title4
        button.setTitle("Send melding", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .primaryBlue
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(messageTapped), for: .touchUpInside)
        return button
    }()

    private lazy var answerTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = .detail
        label.textColor = .stone
        label.text = "Svarer vanligvis innen 4 timer"
        return label
    }()

    // MARK: - External properties
    
    var component: Component? {
        didSet {
//            linkLabel.text = component?.id
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
        guard let component = component else {
            return
        }
        delegate?.messageComponentView(self, didSelectComponent: component)
    }
}

