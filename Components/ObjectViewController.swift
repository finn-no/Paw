import UIKit

class ObjectViewController: UIViewController {

    let attributedDescriptionText: NSAttributedString = {
        let descriptionText = "Selger min bestemors gamle sykkel. 🚲 Den er godt brukt, fungerer godt. Jeg har byttet slange, men latt være å gjøre noe mer på den. Du som kjøper den kan fikse den opp akkurat som du vil ha den :) Jeg ville aldri kjøpt den, men jeg satser på at du er dum nok til å bare gå for det. God jul og lykke til! 🌐 www.finn.no. 📌 Grensen 5, 0134 Oslo. 🗓 12.1.2018. ✈️ DY1234. 📞 12345678. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt."

        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.body,
            NSAttributedStringKey.foregroundColor: UIColor.stone,
        ]
        
        let attributedString = NSAttributedString(string: descriptionText, attributes: attributes)
        return attributedString
    }()

    let priceTableComponents: [TableRowModel] = {
        let locale = Locale(identifier: "no_NO")
        return [
            PriceTableComponent(title: "Prisantydning", price: 2500000, locale: locale),
            PriceTableComponent(title: "Formuesverdi", price: 500000, locale: locale),
            PriceTableComponent(title: "Kommunale avgifter", price: 2100, locale: locale),
        ]
    }()

    let textTableComponents: [TableRowModel] = {
        return [
            TextTableComponent(title: "FINN-kode", detail: "123456789876"),
            TextTableComponent(title: "Sist endret", detail: "25. nov 2017, 08:00"),
        ]
    }()

    var components: [[Component]] {
        return [
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobil", showNumberText: "Vis telefonnummer", accessibilityLabelPrefix: "Telefonnummer: ")],
            [CollapsableDescriptionComponent(text: attributedDescriptionText, titleShow: "+ Vis hele beskrivelsen", titleHide: "- Vis mindre")],
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer"), MessageButtonComponent(title: "Ring", answerTime: "Tar aldri telefonen")],
            [TableComponent(components: priceTableComponents)],
            [TableComponent(components: textTableComponents)],
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
    func objectView(_ objectView: ObjectView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent) {
        print("Vis mer!")
    }
    
    func objectView(_ objectView: ObjectView, didTapHideDescriptionFor component: CollapsableDescriptionComponent) {
        print("Vis mindre!")
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
