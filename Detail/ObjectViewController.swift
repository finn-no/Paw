import UIKit

class ObjectViewController: UIViewController {
    var components: [Component] {
        return [
            Component(id: "c1", type: "link"),
            Component(id: "c2", type: "link"),
            Component(id: "c3", type: "link"),
            Component(id: "c4", type: "link"),
            Component(id: "c5", type: "link"),
            Component(id: "c6", type: "link"),
            Component(id: "c7", type: "link"),
            Component(id: "c8", type: "link"),
            Component(id: "c9", type: "link"),
            Component(id: "c10", type: "link")
        ]
    }

    lazy var objectView: ObjectView = {
        let view = ObjectView()

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(objectView)
        // lay out to fill constraints

        objectView.dataSource = self
        objectView.delegate = self
        objectView.reloadData()
    }
}

extension ObjectViewController: ObjectViewDataSource {
    func componentsInObjectView(_ objectView: ObjectView) -> [Component] {
        return components
    }
}

extension ObjectViewController: ObjectViewDelegate {
    func objectView(_ objectView: ObjectView, didSelectComponent component: Component) {
        print("selected component: \(component.id)")
    }
}
