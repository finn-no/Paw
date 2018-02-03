import UIKit

public protocol SmashViewDataSource: class {
    func components(in smashView: SmashView) -> [[Component]]
    func customComponentView(for component: Component, in smashView: SmashView) -> UIView?
}

public protocol PhoneNumberSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func smashView(_ smashView: SmashView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool
}

public protocol MessageButtonSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapSendMessageFor component: MessageButtonComponent)
}

public protocol IconButtonSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapButtonFor component: IconButtonComponent)
}

public class SmashView: UIView {
    public weak var dataSource: SmashViewDataSource?
    public weak var phoneNumberDelegate: PhoneNumberSmashViewDelegate?
    public weak var messageButtonDelegate: MessageButtonSmashViewDelegate?
    public weak var iconButtonDelegate: IconButtonSmashViewDelegate?

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

    func viewComponent(for component: Component, in smashView: SmashView) -> UIView? {
        switch component.self {
        case is MessageButtonComponent:
            let listComponentView = MessageButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
            listComponentView.component = component as? MessageButtonComponent
            return listComponentView
        case is PhoneNumberComponent:
            let listComponentView = PhoneNumberComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
            listComponentView.component = component as? PhoneNumberComponent
            return listComponentView
        case is IconButtonComponent:
            let listComponentView = IconButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
            listComponentView.component = component as? IconButtonComponent
            return listComponentView
        case is CollapsableDescriptionComponent:
            let listComponentView = CollapsableDescriptionComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
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

extension SmashView: MessageButtonComponentViewDelegate {
    func messageButtonComponentView(_ messageButtonComponentView: MessageButtonComponentView, didTapSendMessageFor component: MessageButtonComponent) {
        messageButtonDelegate?.smashView(self, didTapSendMessageFor: component)
    }
}

// MARK: - PhoneNumberComponentViewDelegate

extension SmashView: PhoneNumberComponentViewDelegate {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        phoneNumberDelegate?.smashView(self, didTapPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return phoneNumberDelegate?.smashView(self, canShowPhoneNumberFor: component) ?? false
    }
}

// MARK: - IconButtonComponentViewDelegate

extension SmashView: IconButtonComponentViewDelegate {
    func iconButtonComponentView(_ adressComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent) {
        iconButtonDelegate?.smashView(self, didTapButtonFor: component)
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
            collapsableDescriptionComponentView.updateButtonTitle()

            UIView.animate(withDuration: self.animationDuration, animations: {
                collapsableDescriptionComponentView.setButtonShowing(showing: true)
            })
        }
    }
}
