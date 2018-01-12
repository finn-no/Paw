import UIKit

class ObjectViewController: UIViewController {

    let pinImage = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)
    let vanImage = UIImage(named: "SmallJobs")

    var components: [[Component]] {
        return [
//            [Component(id: "gallery", type: .gallery)],
//            [Component(id: "title", type: .title)],
//            [Component(id: "price", type: .price)],
//            [Component(id: "message", type: .messageButton)],
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobil", showNumberText: "Vis telefonnummer", accessibilityLabelPrefix: "Telefonnummer: ")],
            [IconButtonComponent(buttonTitle: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [IconButtonComponent(buttonTitle: "Få hjelp til frakt", iconImage: vanImage!)],
//            [Component(id: "proflie", type: .profile)],
//            [Component(id: "adress", type: .adress)],
//            [Component(id: "description", type: .description)],
//            [Component(id: "category", type: .category)],
//            [Component(id: "banner", type: .banner)],
//            [Component(id: "safe", type: .safePay), Component(id: "loan", type: .loanPrice)],
//            [Component(id: "delivery", type: .deliveryHelp)],
//            [Component(id: "adRep", type: .adReporter)],
//            [Component(id: "adInf", type: .adInfo)],
//            [Component(id: "relevant", type: .relevantAds)],
        ]
    }

    let favoriteImage = UIImage(named: "favouriteAdd")?.withRenderingMode(.alwaysTemplate)
    let shareImage = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)

    lazy var shareBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(shareAd))
        item.tintColor = .primaryBlue
        item.accessibilityLabel = "Del annonse"
        return item
    }()
    
    lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favorite))
        item.tintColor = .primaryBlue
        item.accessibilityLabel = "Favoriser annonse"
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
    func objectView(_ objectView: ObjectView, didTapButtonFor component: IconButtonComponent) {
        print("Button with id: \(component.id)")
    }

    func objectView(_ objectView: ObjectView, didTapSendMessageFor component: MessageButtonComponent) {
        print("Send message!")
    }

    func objectView(_ objectView: ObjectView, didTapShowPhoneNumberFor component: PhoneNumberComponent) {
        // Add tracking stuff?
        print("Show phone number for component: \(component.id)")
    }

    func objectView(_ objectView: ObjectView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        if let url = URL(string: "tel://\(component.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
            print("Calling: \(component.phoneNumber)")
        } else {
            print("Not able to call")
        }
    }

    func objectView(_ objectView: ObjectView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        let isUserLoggedIn = true

        if isUserLoggedIn {
            return true
        } else {
            return false
        }
    }
}
