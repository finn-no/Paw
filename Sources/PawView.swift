//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol PawViewDataSource: class {
    func components(in pawView: PawView) -> [[Component]]
    func customComponentView(for component: Component, in pawView: PawView) -> UIView?
}

public protocol GalleryPawViewDelegate: class {
    func pawView(_ pawView: PawView, stringURL: String, imageCallBack: @escaping (_ image: UIImage?) -> Void)
}

public protocol PhoneNumberPawViewDelegate: class {
    func pawView(_ pawView: PawView, didTapPhoneNumberFor component: PhoneNumberComponent)
    func pawView(_ pawView: PawView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool
}

public protocol CallToActionButtonPawViewDelegate: class {
    func pawView(_ pawView: PawView, didTapSendMessageFor component: CallToActionButtonComponent)
}

public protocol LinkPawViewDelegate: class {
    func pawView(_ pawView: PawView, didTapButtonFor component: LinkComponent)
}

public protocol PhoneNumberListPawViewDelegate: class {
    func pawView(_ pawView: PawView, didTapPhoneNumberFor component: PhoneNumberListComponent)
}

public class PawView: UIView {
    public weak var dataSource: PawViewDataSource?
    public weak var galleryDelegate: GalleryPawViewDelegate?
    public weak var phoneNumberDelegate: PhoneNumberPawViewDelegate?
    public weak var callToActionButtonDelegate: CallToActionButtonPawViewDelegate?
    public weak var linkDelegate: LinkPawViewDelegate?
    public weak var phoneNumberListDelegate: PhoneNumberListPawViewDelegate?

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

    func viewComponent(for component: Component, in pawView: PawView) -> UIView? {
        var view: UIView?

        switch component {
        case let component as TitleComponent:
            let listComponentView = TitleComponentView()
            listComponentView.component = component
            view = listComponentView
        case let component as GalleryComponent:
            let galleryComponentView = GalleryComponentView()
            galleryComponentView.delegate = pawView
            galleryComponentView.component = component
            view = galleryComponentView
        case let component as CallToActionButtonComponent:
            let listComponentView = CallToActionButtonComponentView()
            listComponentView.delegate = pawView
            listComponentView.component = component
            view = listComponentView
        case let component as PhoneNumberComponent:
            let listComponentView = PhoneNumberComponentView()
            listComponentView.delegate = pawView
            listComponentView.component = component
            view = listComponentView
        case let component as LinkComponent:
            let listComponentView = LinkComponentView()
            listComponentView.delegate = pawView
            listComponentView.component = component
            view = listComponentView
        case let component as DescriptionComponent:
            let listComponentView = DescriptionComponentView()
            listComponentView.delegate = pawView
            listComponentView.component = component
            view = listComponentView
        case let component as PriceComponent:
            let listComponentView = PriceComponentView()
            listComponentView.component = component
            view = listComponentView
        case let component as SeparatorComponent:
            let separatorComponentView = SeparatorComponentView()
            separatorComponentView.component = component
            view = separatorComponentView
        case let component as TextListComponent:
            let textListComponentView = TextListComponentView()
            textListComponentView.component = component
            view = textListComponentView
        case let component as DateListComponent:
            let dateListComponentView = DateListComponentView()
            dateListComponentView.component = component
            view = dateListComponentView
        case let component as PhoneNumberListComponent:
            let phoneNumberListComponentView = PhoneNumberListComponentView()
            phoneNumberListComponentView.delegate = pawView
            phoneNumberListComponentView.component = component
            view = phoneNumberListComponentView
        default: break
        }

        view?.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
}

extension PawView: GalleryComponentViewDelegate {
    func galleryComponentView(_ galleryComponentView: GalleryComponentView, stringURL: String, imageCallBack: @escaping (_ image: UIImage?) -> Void) {
        galleryDelegate?.pawView(self, stringURL: stringURL, imageCallBack: imageCallBack)
    }
}

extension PawView: CallToActionButtonComponentViewDelegate {
    func callToActionButtonComponentView(_ callToActionButtonComponentView: CallToActionButtonComponentView, didTapSendMessageFor component: CallToActionButtonComponent) {
        callToActionButtonDelegate?.pawView(self, didTapSendMessageFor: component)
    }
}

extension PawView: PhoneNumberComponentViewDelegate {
    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        phoneNumberDelegate?.pawView(self, didTapPhoneNumberFor: component)
    }

    func phoneNumberComponentView(_ phoneNumberComponentView: PhoneNumberComponentView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return phoneNumberDelegate?.pawView(self, canShowPhoneNumberFor: component) ?? false
    }
}

extension PawView: LinkComponentViewDelegate {
    func linkComponentView(_ adressComponentView: LinkComponentView, didTapButtonFor component: LinkComponent) {
        linkDelegate?.pawView(self, didTapButtonFor: component)
    }
}

extension PawView: DescriptionComponentViewDelegate {
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

extension PawView: PhoneNumberListComponentViewDelegate {
    func phoneNumberListComponentView(_ phoneNumberListComponentView: PhoneNumberListComponentView, didTapPhoneNumberFor component: PhoneNumberListComponent) {
        phoneNumberListDelegate?.pawView(self, didTapPhoneNumberFor: component)
    }
}
