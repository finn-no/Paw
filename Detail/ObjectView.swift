import UIKit

protocol ObjectViewDataSource: class {
    func components(in objectView: ObjectView) -> [[Component]]
    func customComponentView(for component: Component, in objectView: ObjectView) -> UIView?
}

protocol ObjectViewDelegate: class {
    func objectView(_ objectView: ObjectView, didSelectComponent component: Component)
}

class ObjectView: UIView {
    weak var dataSource: ObjectViewDataSource?
    weak var delegate: ObjectViewDelegate?

    lazy var scrollView: UIScrollView = {
        let view =  UIScrollView(frame: .zero)
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

    func reloadData() {
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

                switch rowIndex {
                case 0:
                    NSLayoutConstraint.activate([
                        componentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumLargeSpacing),
                        ])
                case components.count-1:
                    guard let previousStackView = previousStackView else {
                        fatalError()
                    }
                    NSLayoutConstraint.activate([
                        componentStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor, constant: .mediumLargeSpacing),
                        componentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumLargeSpacing),
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

    func viewComponent(for component: Component, in objectView: ObjectView) -> UIView? {
        switch component.type {
        case .link:
            let listComponentView = LinkComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.delegate = objectView
            listComponentView.component = component
            listComponentView.setupLayout()
            return listComponentView
        case .title:
            let listComponentView = TitleView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            return listComponentView
        case .custom:
            if let listComponentView = dataSource?.customComponentView(for: component, in: objectView) {
                listComponentView.translatesAutoresizingMaskIntoConstraints = false
                return listComponentView
            } else {
                return nil
            }
        }
    }

    func setupStackView() -> UIStackView {
        let stackView: UIStackView = {
            let view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.distribution = .fillEqually
            view.spacing = .mediumSpacing
            return view
        }()
        return stackView
    }
}

extension ObjectView: LinkComponentViewDelegate {
    func linkComponentView(_ linkComponentView: LinkComponentView, didSelectComponent component: Component) {
        delegate?.objectView(self, didSelectComponent: component)
    }
}
