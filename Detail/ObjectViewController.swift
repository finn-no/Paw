import UIKit

class ObjectViewController: UIViewController {
    var component: [Component] {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        objectView.dataSource = self
        objectView.delegate = self
    }
}

extension ObjectViewController: ObjectViewDataSource {

}

extension ObjectViewController: ObjectViewDelegate {
    
}
