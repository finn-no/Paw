import UIKit

protocol LinkComponentViewDelegate: class {
    func linkComponentView(_ linkComponentView: LinkComponentView, didSelectComponent component: Component)
}

class LinkComponentView: UIView {
    weak var delegate: LinkComponentViewDelegate?
    var component: Component?
}
