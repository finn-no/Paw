//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol AstrupViewDataSource: class {
    func components(in astrupView: AstrupView) -> [[Component]]
    func customComponentView(for component: Component, in astrupView: AstrupView) -> UIView?
}

public protocol GalleryAstrupViewDelegate: class {
    func astrupView(_ astrupView: AstrupView, stringURL: String, imageCallBack: @escaping (_ image: UIImage?) -> Void)
}

public protocol PhoneNumberAstrupViewDelegate: class {
    func astrupView(_ astrupView: AstrupView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func astrupView(_ astrupView: AstrupView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool
}

public protocol CallToActionButtonAstrupViewDelegate: class {
    func astrupView(_ astrupView: AstrupView, didTapSendMessageFor component: CallToActionButtonComponent)
}

public protocol LinkAstrupViewDelegate: class {
    func astrupView(_ astrupView: AstrupView, didTapButtonFor component: LinkComponent)
}

public protocol PhoneNumberListAstrupViewDelegate: class {
    func astrupView(_ astrupView: AstrupView, didTapPhoneNumberFor component: PhoneNumberListComponent)
}

public class AstrupView: UIView {
    public weak var dataSource: AstrupViewDataSource?
    public weak var galleryDelegate: GalleryAstrupViewDelegate?
    public weak var phoneNumberDelegate: PhoneNumberAstrupViewDelegate?
    public weak var callToActionButtonDelegate: CallToActionButtonAstrupViewDelegate?
    public weak var linkDelegate: LinkAstrupViewDelegate?
    public weak var phoneNumberListDelegate: PhoneNumberListAstrupViewDelegate?

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
                if let componentView = self.dataSource?.customComponentView(for: component, in: self) {
                    rowStackView.addArrangedSubview(componentView)
                } else if let componentView = viewComponent(for: component, in: self) {
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

    func viewComponent(for component: Component, in astrupView: AstrupView) -> UIView? {
        switch component.self {
        case is TitleComponent:
            let listComponentView = TitleComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? TitleComponent
            return listComponentView
        case is GalleryComponent:
            let galleryComponentView = GalleryComponentView()
            galleryComponentView.translatesAutoresizingMaskIntoConstraints = false
            galleryComponentView.delegate = astrupView
            galleryComponentView.component = component as? GalleryComponent
            return galleryComponentView
        case is CallToActionButtonComponent:
            let listComponentView = CallToActionButtonComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = astrupView
            listComponentView.component = component as? CallToActionButtonComponent
            return listComponentView
        case is PhoneNumberComponent:
            let listComponentView = PhoneNumberComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = astrupView
            listComponentView.component = component as? PhoneNumberComponent
            return listComponentView
        case is LinkComponent:
            let listComponentView = LinkComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = astrupView
            listComponentView.component = component as? LinkComponent
            return listComponentView
        case is DescriptionComponent:
            let listComponentView = DescriptionComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = astrupView
            listComponentView.component = component as? DescriptionComponent
            return listComponentView
        case is PriceComponent:
            let listComponentView = PriceComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? PriceComponent
            return listComponentView
        case is SeparatorComponent:
            let separatorComponentView = SeparatorComponentView()
            separatorComponentView.translatesAutoresizingMaskIntoConstraints = false
            separatorComponentView.component = component as? SeparatorComponent
            return separatorComponentView
        case is TextListComponent:
            let textListComponentView = TextListComponentView()
            textListComponentView.translatesAutoresizingMaskIntoConstraints = false
            textListComponentView.component = component as? TextListComponent
            return textListComponentView
        case is DateListComponent:
            let dateListComponentView = DateListComponentView()
            dateListComponentView.translatesAutoresizingMaskIntoConstraints = false
            dateListComponentView.component = component as? DateListComponent
            return dateListComponentView
        case is PhoneNumberListComponent:
            let phoneNumberListComponentView = PhoneNumberListComponentView()
            phoneNumberListComponentView.translatesAutoresizingMaskIntoConstraints = false
            phoneNumberListComponentView.delegate = astrupView
            phoneNumberListComponentView.component = component as? PhoneNumberListComponent
            return phoneNumberListComponentView
        default: return nil
        }
    }
}

extension AstrupView: GalleryComponentViewDelegate {
    func galleryComponentView(_ galleryComponentView: GalleryComponentView, stringURL: String, imageCallBack: @escaping (_ image: UIImage?) -> Void) {
        galleryDelegate?.astrupView(self, stringURL: stringURL, imageCallBack: imageCallBack)
    }
}

extension AstrupView: CallToActionButtonComponentViewDelegate {
    func callToActionButtonComponentView(_ callToActionButtonComponentView: CallToActionButtonComponentView, didTapSendMessageFor component: CallToActionButtonComponent) {
        callToActionButtonDelegate?.astrupView(self, didTapSendMessageFor: component)
    }
}

extension AstrupView: PhoneNumberComponentViewDelegate {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        phoneNumberDelegate?.astrupView(self, didTapPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return phoneNumberDelegate?.astrupView(self, canShowPhoneNumberFor: component) ?? false
    }
}

extension AstrupView: LinkComponentViewDelegate {
    func linkComponentView(_ adressComponentView: LinkComponentView, didTapButtonFor component: LinkComponent) {
        linkDelegate?.astrupView(self, didTapButtonFor: component)
    }
}

extension AstrupView: DescriptionComponentViewDelegate {
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

extension AstrupView: PhoneNumberListComponentViewDelegate {
    func phoneNumberListComponentView(_ phoneNumberListComponentView: PhoneNumberListComponentView, didTapPhoneNumberFor component: PhoneNumberListComponent) {
        phoneNumberListDelegate?.astrupView(self, didTapPhoneNumberFor: component)
    }
}
