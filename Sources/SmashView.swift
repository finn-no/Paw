//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol SmashViewDataSource: class {
    func components(in smashView: SmashView) -> [[Component]]
    func customComponentView(for component: Component, in smashView: SmashView) -> UIView?
}

public protocol PhoneNumberSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func smashView(_ smashView: SmashView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool
}

public protocol CallToActionButtonSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapSendMessageFor component: CallToActionButtonComponent)
}

public protocol IconButtonSmashViewDelegate: class {
    func smashView(_ smashView: SmashView, didTapButtonFor component: IconButtonComponent)
}

public class SmashView: UIView {
    public weak var dataSource: SmashViewDataSource?
    public weak var phoneNumberDelegate: PhoneNumberSmashViewDelegate?
    public weak var callToActionButtonDelegate: CallToActionButtonSmashViewDelegate?
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
            let rowStackView = UIStackView()
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillProportionally
            rowStackView.spacing = .mediumSpacing

            for component in componentRow {
                if let componentView = viewComponent(for: component, in: self) {
                    rowStackView.addArrangedSubview(componentView)
                }
            }

            if rowStackView.arrangedSubviews.count > 0 {
                contentView.addSubview(rowStackView)

                NSLayoutConstraint.activate([
                    rowStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    rowStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                ])

                if components.count == 1 {
                    NSLayoutConstraint.activate([
                        rowStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        rowStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    ])
                } else {
                    switch rowIndex {
                    case 0:
                        NSLayoutConstraint.activate([
                            rowStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        ])
                    case components.count - 1:
                        guard let previousStackView = previousStackView else {
                            fatalError()
                        }
                        NSLayoutConstraint.activate([
                            rowStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor, constant: .mediumLargeSpacing),
                            rowStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumSpacing),
                        ])
                    default:
                        guard let previousStackView = previousStackView else {
                            fatalError()
                        }
                        NSLayoutConstraint.activate([
                            rowStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor, constant: .mediumLargeSpacing),
                        ])
                    }
                    previousStackView = rowStackView
                }
            }
        }
    }

    func viewComponent(for component: Component, in smashView: SmashView) -> UIView? {
        switch component.self {
        case is CallToActionButtonComponent:
            let listComponentView = CallToActionButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
            listComponentView.component = component as? CallToActionButtonComponent
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
        case is DescriptionComponent:
            let listComponentView = DescriptionComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = smashView
            listComponentView.component = component as? DescriptionComponent
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
}

extension SmashView: CallToActionButtonComponentViewDelegate {
    func callToActionButtonComponentView(_ callToActionButtonComponentView: CallToActionButtonComponentView, didTapSendMessageFor component: CallToActionButtonComponent) {
        callToActionButtonDelegate?.smashView(self, didTapSendMessageFor: component)
    }
}

extension SmashView: PhoneNumberComponentViewDelegate {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        phoneNumberDelegate?.smashView(self, didTapPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return phoneNumberDelegate?.smashView(self, canShowPhoneNumberFor: component) ?? false
    }
}

extension SmashView: IconButtonComponentViewDelegate {
    func iconButtonComponentView(_ adressComponentView: IconButtonComponentView, didTapButtonFor component: IconButtonComponent) {
        iconButtonDelegate?.smashView(self, didTapButtonFor: component)
    }
}

extension SmashView: DescriptionComponentViewDelegate {
    func descriptionComponentView(_ descriptionComponentView: DescriptionComponentView, didTapExpandDescriptionFor component: DescriptionComponent) {
        UIView.animate(withDuration: animationDuration, animations: {
            descriptionComponentView.layoutIfNeeded()
            descriptionComponentView.setButtonShowing(showing: false)
            self.layoutIfNeeded()
        }) { _ in
            descriptionComponentView.updateButtonTitle()

            UIView.animate(withDuration: self.animationDuration, animations: {
                descriptionComponentView.setButtonShowing(showing: true)
            })
        }
    }

    func descriptionComponentView(_ descriptionComponentView: DescriptionComponentView, didTapHideDescriptionFor component: DescriptionComponent) {
        UIView.animate(withDuration: animationDuration, animations: {
            descriptionComponentView.layoutIfNeeded()
            descriptionComponentView.setButtonShowing(showing: false)
            self.layoutIfNeeded()
        }) { _ in
            descriptionComponentView.updateButtonTitle()

            UIView.animate(withDuration: self.animationDuration, animations: {
                descriptionComponentView.setButtonShowing(showing: true)
            })
        }
    }
}
