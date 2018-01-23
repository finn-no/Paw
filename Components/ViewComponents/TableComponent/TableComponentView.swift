import UIKit

public class TableComponentView: UIView {

    // MARK: - Internal properties

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = .mediumSpacing
        return view
    }()

    // MARK: - External properties

    var component: TableComponent? {
        didSet {
            guard let components = component?.components else {
                return
            }
            setupTable(components: components)
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
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    // MARK: - Methods

    private func setupTable(components: [TableRowModel]) {
        for component in components {
            if let componentView = viewComponent(for: component, in: self) {
                stackView.addArrangedSubview(componentView)
            }
        }
    }

    private func viewComponent(for component: TableRowModel, in tableComponentView: TableComponentView) -> UIView? {
        switch component.self {
        case is PriceTableComponent:
            let listComponentView = PriceTableComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? PriceTableComponent
            return listComponentView
        default: return nil
        }
    }
}
