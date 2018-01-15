import UIKit

protocol CollapsableDescriptionComponentViewDelegate: class {
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent)
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapHideDescriptionFor component: CollapsableDescriptionComponent)
}

public class CollapsableDescriptionComponentView: UIView {

    // MARK: - Internal properties

    private var textViewHeightConstraint: NSLayoutConstraint?
    private var isWholeTextShowing: Bool = false
    private let animationDuration = 0.4

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isAccessibilityElement = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = .body
        textView.textColor = .stone
        textView.dataDetectorTypes = .all
        return textView
    }()

    private lazy var showWholeDescriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(showWholeDescriptionAction), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: .mediumSpacing, left: 0, bottom: .mediumSpacing, right: 0)
        button.titleLabel?.font = .title4
        return button
    }()

    // MARK: - External properties

    weak var delegate: CollapsableDescriptionComponentViewDelegate?
    var component: CollapsableDescriptionComponent? {
        didSet {
            descriptionTextView.text = component?.text
            showWholeDescriptionButton.setTitle(component?.titleShow, for: .normal) // "+ Vis hele beskrivelsen"
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
        addSubview(descriptionTextView)
        addSubview(showWholeDescriptionButton)

        textViewHeightConstraint = descriptionTextView.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textViewHeightConstraint!,

            showWholeDescriptionButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
            showWholeDescriptionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            showWholeDescriptionButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            showWholeDescriptionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func showWholeDescriptionAction(sender: UIButton) {
        guard let component = component, let delegate = delegate else {
            return
        }

        if isWholeTextShowing {
            delegate.collapsableDescriptionComponentView(self, didTapHideDescriptionFor: component)

            showWholeDescriptionButton.setTitle(self.component?.titleShow, for: .normal)    // "+ Vis hele beskrivelsen"
            textViewHeightConstraint?.isActive = true

            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)

            isWholeTextShowing = false
        } else {
            delegate.collapsableDescriptionComponentView(self, didTapExpandDescriptionFor: component)

            showWholeDescriptionButton.setTitle(self.component?.titleHide, for: .normal)    // "- Vis mindre"
            textViewHeightConstraint?.isActive = false

            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)

            isWholeTextShowing = true
        }
    }
}

