import UIKit

protocol ObjectViewDataSource: class {
    func componentsInObjectView(_ objectView: ObjectView) -> [Component]
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

        let components = dataSource?.componentsInObjectView(self) ?? [Component]()
        var previousLinkComponent = LinkComponentView()
        for (index, component) in components.enumerated() {
            if component.type == "link" {
                // add each as subview and lay out
                let linkComponent = LinkComponentView()
                linkComponent.delegate = self
                linkComponent.component = component

                contentView.addSubview(linkComponent)

                linkComponent.setupLayout()

                NSLayoutConstraint.activate([
                    linkComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
                    linkComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
                ])

                switch index {
                case 0:
                    NSLayoutConstraint.activate([
                        linkComponent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumLargeSpacing),
                    ])
                case components.count-1:
                    NSLayoutConstraint.activate([
                        linkComponent.topAnchor.constraint(equalTo: previousLinkComponent.bottomAnchor, constant: .mediumLargeSpacing),
                        linkComponent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumLargeSpacing),
                    ])
                default:
                    NSLayoutConstraint.activate([
                        linkComponent.topAnchor.constraint(equalTo: previousLinkComponent.bottomAnchor, constant: .mediumLargeSpacing),
                    ])
                }
                previousLinkComponent = linkComponent
            }
        }
    }
}

extension ObjectView: LinkComponentViewDelegate {
    func linkComponentView(_ linkComponentView: LinkComponentView, didSelectComponent component: Component) {
        delegate?.objectView(self, didSelectComponent: component)
    }
}
