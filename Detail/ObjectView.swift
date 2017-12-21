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
        return UIScrollView()
    }()

    func reloadData() {
        for subview in subviews {
            subview.removeFromSuperview()
        }

        let components = dataSource?.componentsInObjectView(self) ?? [Component]()
        for component in components {
            if component.type == "link" {
                // add each as subview and lay out
                let linkComponent = LinkComponentView()
                linkComponent.delegate = self
            }
        }
    }
}

extension ObjectView: LinkComponentViewDelegate {
    func linkComponentView(_ linkComponentView: LinkComponentView, didSelectComponent component: Component) {
        delegate?.objectView(self, didSelectComponent: component)
    }
}
