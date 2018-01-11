import UIKit

protocol LinkComponentViewDelegate: class {
    func linkComponentView(_ linkComponentView: LinkComponentView, didSelectComponent component: Component)
}

class LinkComponentView: UIView {
    weak var delegate: LinkComponentViewDelegate?

    lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title4
        label.textColor = .licorice
        return label
    }()

    var component: Component? {
        didSet {
            linkLabel.text = component?.id
        }
    }

    func setupLayout() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        gestureRecognizers = [tapGesture]

        translatesAutoresizingMaskIntoConstraints = false
        addSubview(linkLabel)

        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: topAnchor),
            linkLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    @objc private func tapAction() {
        guard let component = component else {
            return
        }
        delegate?.linkComponentView(self, didSelectComponent: component)
    }
}
