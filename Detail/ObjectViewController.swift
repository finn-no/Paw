import UIKit

class ObjectViewController: UIViewController {
    var components: [[Component]] {
        return [
            [Component(id: "gallery", type: .gallery)],
            [Component(id: "title", type: .title)],
            [Component(id: "price", type: .price)],
            [Component(id: "message", type: .messageButton)],
            [Component(id: "show", type: .showNumberButton)],
            [Component(id: "proflie", type: .profile)],
            [Component(id: "adress", type: .adress)],
            [Component(id: "description", type: .description)],
            [Component(id: "category", type: .category)],
            [Component(id: "banner", type: .banner)],
            [Component(id: "safe", type: .safePay), Component(id: "loan", type: .loanPrice)],
            [Component(id: "delivery", type: .deliveryHelp)],
            [Component(id: "adRep", type: .adReporter)],
            [Component(id: "adInf", type: .adInfo)],
            [Component(id: "relevant", type: .relevantAds)],
        ]
    }

    let favoriteImage = UIImage(named: "favouriteAdd")?.withRenderingMode(.alwaysTemplate)
    let shareImage = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)

    lazy var shareBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(shareAd))
        item.tintColor = .primaryBlue
        return item
    }()
    
    lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favorite))
        item.tintColor = .primaryBlue
        return item
    }()

    lazy var objectView: ObjectView = {
        let view = ObjectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setRightBarButtonItems([favoriteBarButtonItem, shareBarButtonItem], animated: false)

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

    @objc func favorite(sender: UIButton) {
        print("Favorite added!")
    }
    @objc func shareAd(sender: UIButton) {
        print("Share ad!")
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
