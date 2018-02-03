import UIKit

public protocol SmashViewDataSource: class {
    func components(in objectView: SmashView) -> [[Component]]
    func customComponentView(for component: Component, in objectView: SmashView) -> UIView?
}

public protocol SmashViewDelegate: class {
    // PhoneNumberComponentViewDelegate
    func objectView(_ objectView: SmashView, didTapShowPhoneNumberFor component: PhoneNumberComponent)
    func objectView(_ objectView: SmashView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func objectView(_ objectView: SmashView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool

    // MessageButtonComponentViewDelegate
    func objectView(_ objectView: SmashView, didTapSendMessageFor component: MessageButtonComponent)

    // IconButtonComponentViewDelegate
    func objectView(_ objectView: SmashView, didTapButtonFor component: IconButtonComponent)

    // CollapsableDescriptionComponentViewDelegate
    func objectView(_ objectView: SmashView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent)
    func objectView(_ objectView: SmashView, didTapHideDescriptionFor component: CollapsableDescriptionComponent)
}

public class SmashView: UIView {
    public weak var dataSource: SmashViewDataSource?
    public weak var delegate: SmashViewDelegate?

    private let animationDuration = 0.4

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        scrollView.addSubview(contentView)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    public func reloadData() {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }

        guard let dataSource = dataSource else {
            return
        }

        let components = dataSource.components(in: self)
        var previousStackView: UIStackView?

        for (rowIndex, componentRow) in components.enumerated() {
            let componentStackView = setupStackView()

            for component in componentRow {
                if let componentView = viewComponent(for: component, in: self) {
                    componentStackView.addArrangedSubview(componentView)
                }
            }

            if componentStackView.arrangedSubviews.count > 0 {
                contentView.addSubview(componentStackView)

                NSLayoutConstraint.activate([
                    componentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
                    componentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
                ])

                if components.count == 1 {
                    NSLayoutConstraint.activate([
                        componentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        componentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    ])
                } else {
                    switch rowIndex {
                    case 0:
                        NSLayoutConstraint.activate([
                            componentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        ])
                    case components.count - 1:
                        guard let previousStackView = previousStackView else {
                            fatalError()
                        }
                        NSLayoutConstraint.activate([
                            componentStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor, constant: .mediumLargeSpacing),
                            componentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumSpacing),
                        ])
                    default:
                        guard let previousStackView = previousStackView else {
                            fatalError()
                        }
                        NSLayoutConstraint.activate([
                            componentStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor, constant: .mediumLargeSpacing),
                        ])
                    }
                    previousStackView = componentStackView
                }
            }
        }
    }

    func viewComponent(for component: Component, in objectView: SmashView) -> UIView? {
        switch component.self {
        case is MessageButtonComponent:
            let listComponentView = MessageButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = objectView
            listComponentView.component = component as? MessageButtonComponent
            return listComponentView
        case is PhoneNumberComponent:
            let listComponentView = PhoneNumberComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = objectView
            listComponentView.component = component as? PhoneNumberComponent
            return listComponentView
        case is IconButtonComponent:
            let listComponentView = IconButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = objectView
            listComponentView.component = component as? IconButtonComponent
            return listComponentView
        case is CollapsableDescriptionComponent:
            let listComponentView = CollapsableDescriptionComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = objectView
            listComponentView.component = component as? CollapsableDescriptionComponent
            return listComponentView
        case is PriceComponent:
            let listComponentView = PriceComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? PriceComponent
            return listComponentView
        case is TableComponent:
            let listComponentView = TableComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? TableComponent
            return listComponentView
        default: return nil
        }
    }

    func setupStackView() -> UIStackView {
        let stackView: UIStackView = {
            let view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.distribution = .fillProportionally
            view.spacing = .mediumSpacing
            return view
        }()
        return stackView
    }
}

// MARK: - MessageButtonComponentViewDelegate

extension SmashView: MessageComponentViewDelegate {
    func messageComponentView(_ messageComponentView: MessageButtonComponentView, didTapSendMessageFor component: MessageButtonComponent) {
        delegate?.objectView(self, didTapSendMessageFor: component)
    }
}

// MARK: - PhoneNumberComponentViewDelegate

extension SmashView: PhoneNumberComponentViewDelegate {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapShowPhoneNumberFor component: PhoneNumberComponent) {
        delegate?.objectView(self, didTapShowPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        delegate?.objectView(self, didTapPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return delegate?.objectView(self, canShowPhoneNumberFor: component) ?? false
    }
}

// MARK: - IconButtonComponentViewDelegate

extension SmashView: IconButtonComponentViewDelegate {
    func iconButtonComponentView(_ adressComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent) {
        delegate?.objectView(self, didTapButtonFor: component)
    }
}

// MARK: - CollapsableDescriptionComponentViewDelegate

extension SmashView: CollapsableDescriptionComponentViewDelegate {
    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent) {
        UIView.animate(withDuration: animationDuration, animations: {
            collapsableDescriptionComponentView.layoutIfNeeded()
            collapsableDescriptionComponentView.setButtonShowing(showing: false)
            self.layoutIfNeeded()
        }) { _ in
            self.delegate?.objectView(self, didTapExpandDescriptionFor: component)
            collapsableDescriptionComponentView.updateButtonTitle()

            UIView.animate(withDuration: self.animationDuration, animations: {
                collapsableDescriptionComponentView.setButtonShowing(showing: true)
            })
        }
    }

    func collapsableDescriptionComponentView(_ collapsableDescriptionComponentView: CollapsableDescriptionComponentView, didTapHideDescriptionFor component: CollapsableDescriptionComponent) {
        UIView.animate(withDuration: animationDuration, animations: {
            collapsableDescriptionComponentView.layoutIfNeeded()
            collapsableDescriptionComponentView.setButtonShowing(showing: false)
            self.layoutIfNeeded()
        }) { _ in
            self.delegate?.objectView(self, didTapHideDescriptionFor: component)
            collapsableDescriptionComponentView.updateButtonTitle()

            UIView.animate(withDuration: self.animationDuration, animations: {
                collapsableDescriptionComponentView.setButtonShowing(showing: true)
            })
        }
    }
}
