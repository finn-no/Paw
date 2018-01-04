import UIKit

class ObjectViewController: UIViewController {
    var components: [[Component]] {
        return [
            [Component(id: "c1", type: .gallery)],
            [Component(id: "c2", type: .title)],
            [Component(id: "c3a", type: .price)],
            [Component(id: "c4", type: .messageButton)],
            [Component(id: "c5", type: .showNumberButton)],
            [Component(id: "c6", type: .profile)],
            [Component(id: "c7", type: .adress)],
            [Component(id: "c8", type: .description)],
            [Component(id: "c9a", type: .category)],
            [Component(id: "c10", type: .banner)],
            [Component(id: "c11", type: .safePay), Component(id: "c11", type: .loanPrice)],
            [Component(id: "c12", type: .deliveryHelp)],
            [Component(id: "c13", type: .adReporter)],
            [Component(id: "c14", type: .adInfo)],
            [Component(id: "c15", type: .relevantAds)],
        ]
    }

    lazy var objectView: ObjectView = {
        let view = ObjectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(objectView)
        // lay out to fill constraints

        NSLayoutConstraint.activate([
            objectView.topAnchor.constraint(equalTo: view.topAnchor),
            objectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            objectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            objectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        objectView.dataSource = self
        objectView.delegate = self
        objectView.reloadData()
    }
}

extension ObjectViewController: ObjectViewDataSource {
    func components(in objectView: ObjectView) -> [[Component]] {
        return components
    }

    func customComponentView(for component: Component,in objectView: ObjectView) -> UIView? {
        switch component.id {
        case "custom1": return CustomView()
        default: return nil
        }
    }
}

extension ObjectViewController: ObjectViewDelegate {
    func objectView(_ objectView: ObjectView, didSelectComponent component: Component) {
        print("selected component: \(component.id)")
    }
}
