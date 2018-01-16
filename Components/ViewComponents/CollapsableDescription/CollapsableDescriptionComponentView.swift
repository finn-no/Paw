import UIKit

protocol CollapsableDescriptionComponentViewDelegate: class {
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent)
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapHideDescriptionFor component: CollapsableDescriptionComponent)
}

public class CollapsableDescriptionComponentView: UIView {

    // MARK: - Internal properties

    private var textHeightConstraint: NSLayoutConstraint?
    private var isWholeTextShowing: Bool = false
    private let collapsedDescriptionHeight: CGFloat = 86

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
            showWholeDescriptionButton.setTitle(component?.titleShow, for: .normal)
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

        textHeightConstraint = descriptionTextView.heightAnchor.constraint(lessThanOrEqualToConstant: collapsedDescriptionHeight)

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textHeightConstraint!,

            showWholeDescriptionButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
            showWholeDescriptionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            showWholeDescriptionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            showWholeDescriptionButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func showWholeDescriptionAction(sender: UIButton) {
        guard let component = component, let delegate = delegate else {
            return
        }

        if isWholeTextShowing {
            textHeightConstraint?.isActive = true

            delegate.collapsableDescriptionComponentView(self, didTapHideDescriptionFor: component)
            isWholeTextShowing = false
        } else {
            textHeightConstraint?.isActive = false

            delegate.collapsableDescriptionComponentView(self, didTapExpandDescriptionFor: component)
            isWholeTextShowing = true
        }
    }

    func updateButtonTitle() {
        if isWholeTextShowing {
            showWholeDescriptionButton.setTitle(self.component?.titleHide, for: .normal)
        } else {
            showWholeDescriptionButton.setTitle(self.component?.titleShow, for: .normal)
        }
    }

    func setButtonShowing(showing: Bool) {
        if showing {
            showWholeDescriptionButton.alpha = 1
        } else {
            showWholeDescriptionButton.alpha = 0
        }
    }
}

