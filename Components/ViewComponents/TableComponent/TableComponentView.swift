import UIKit

public class TableComponentView: UIView {

    // MARK: - Internal properties

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = .smallSpacing
        view.distribution = .fill
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

    private func setupTable(components: [TableElement]) {
        for component in components {
            let separatorView = setupSeparatorView()

            if let componentView = viewComponent(for: component, in: self) {
                stackView.addArrangedSubview(componentView)
                stackView.addArrangedSubview(separatorView)
                separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
                separatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            }
        }
        if let lastView = stackView.arrangedSubviews.last {
            stackView.removeArrangedSubview(lastView)
        }
    }

    private func viewComponent(for component: TableElement, in tableComponentView: TableComponentView) -> UIView? {
        switch component.self {
        case is TextTableComponent:
            let listComponentView = TextTableComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? TextTableComponent
            return listComponentView
        case is DateTableComponent:
            let listComponentView = DateTableComponentView()
            listComponentView.translatesAutoresizingMaskIntoConstraints = false
            listComponentView.component = component as? DateTableComponent
            return listComponentView
        default: return nil
        }
    }

    private func setupSeparatorView() -> UIView {
        let separatorView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .sardine
            return view
        }()
        return separatorView
    }
}
