import UIKit

protocol CollapsableDescriptionComponentViewDelegate: class {
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent)
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapHideDescriptionFor component: CollapsableDescriptionComponent)
}

public class CollapsableDescriptionComponentView: UIView {

    // MARK: - Internal properties

    private let maximumNumberOfLines = 5

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.numberOfLines = 5
        label.font = .body
        label.textColor = .stone
        return label
    }()

    private lazy var showWholeDescriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(showWholeDescriptionAction), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = .title4
        return button
    }()

    // MARK: - External properties

    weak var delegate: CollapsableDescriptionComponentViewDelegate?
    var component: CollapsableDescriptionComponent? {
        didSet {
            descriptionLabel.text = component?.text
            showWholeDescriptionButton.setTitle(component?.titleShow, for: .normal) // "+ Vis hele beskrivelsen"
            descriptionLabel.accessibilityLabel = component?.text
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
        addSubview(descriptionLabel)
        addSubview(showWholeDescriptionButton)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            showWholeDescriptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .mediumSpacing),
            showWholeDescriptionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            showWholeDescriptionButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            showWholeDescriptionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func showWholeDescriptionAction(sender: UIButton) {
        if descriptionLabel.numberOfLines >= maximumNumberOfLines {
            print("Vis hele beskrivelsen!")
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.showWholeDescriptionButton.setTitle(self.component?.titleHide, for: .normal)    // "- Vis mindre"
                self.descriptionLabel.numberOfLines = 0
                self.descriptionLabel.sizeToFit()
            }, completion: nil)
        } else {
            print("Vis mindre av beskrivelsen!")
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.showWholeDescriptionButton.setTitle(self.component?.titleShow, for: .normal)    // "+ Vis hele beskrivelsen"
                self.descriptionLabel.numberOfLines = self.maximumNumberOfLines
                self.descriptionLabel.sizeToFit()
            }, completion: nil)
        }
    }
}

