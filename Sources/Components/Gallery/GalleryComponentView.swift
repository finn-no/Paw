//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class GalleryComponentView: UIView {
    fileprivate let defaultHeight: CGFloat = 250
    fileprivate var shoudEvaluatePageChange = false
    fileprivate var currentPage: Int = 0

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.delegate = self
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally

        return view
    }()

    var component: GalleryComponent? {
        didSet {
            guard let component = component else {
                return
            }

            addImageViews(for: component)
            loadPage(0)
            loadPage(1)
            loadPage(2)
        }
    }

    func addImageViews(for component: GalleryComponent) {
        horizontalStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }

        component.loadables.forEach { _ in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            horizontalStackView.addArrangedSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                imageView.heightAnchor.constraint(equalToConstant: defaultHeight),
            ])
        }
    }

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
        contentView.addSubview(horizontalStackView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    fileprivate func loadPage(_ page: Int) {
        let numPages = component?.loadables.count ?? 0
        if page >= numPages || page < 0 {
            return
        }

        guard let loadable = component?.loadables[page] else {
            return
        }

        if horizontalStackView.arrangedSubviews.count > page {
            let imageView = horizontalStackView.arrangedSubviews[page] as? UIImageView
            loadable.load { result in
                switch result {
                case let .success(image):
                    imageView?.image = image
                case .failure:
                    imageView?.image = nil
                }
            }
        }
    }
}

extension GalleryComponentView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shoudEvaluatePageChange = true
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        shoudEvaluatePageChange = false
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if shoudEvaluatePageChange {
            let pageWidth = frame.size.width
            let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
            currentPage = page

            loadPage(page - 1)
            loadPage(page)
            loadPage(page + 1)
        }
    }
}
