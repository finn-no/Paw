import Smash
import UIKit

class DemoViewController: UIViewController {
    let pinImage = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)
    let vanImage = UIImage(named: "SmallJobs")

    let attributedDescriptionText: NSAttributedString = {
        let descriptionText = "Selger min bestemors gamle sykkel. 🚲 Den er godt brukt, fungerer godt. Jeg har byttet slange, men latt være å gjøre noe mer på den. Du som kjøper den kan fikse den opp akkurat som du vil ha den :) Jeg ville aldri kjøpt den, men jeg satser på at du er dum nok til å bare gå for det. God jul og lykke til! 🌐 www.finn.no. 📌 Grensen 5, 0134 Oslo. 🗓 12.1.2018. ✈️ DY1234. 📞 12345678. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt."

        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.body,
            NSAttributedStringKey.foregroundColor: UIColor.stone,
        ]

        let attributedString = NSAttributedString(string: descriptionText, attributes: attributes)
        return attributedString
    }()

    let torgetTableElements: [TableElement] = {
        let locale = Locale(identifier: "nb_NO")
        let timeInterval = TimeInterval(exactly: 450_033_400)!
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        return [
            TextTableElement(title: "FINN-kode", detail: "123456789"),
            DateTableElement(title: "Sist endret", date: date),
        ]
    }()

    var components: [[Component]] {
        let locale = Locale(identifier: "nb_NO")
        return [
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobil", showNumberText: "Vis telefonnummer", accessibilityLabelPrefix: "Telefonnummer: ")],
            [IconButtonComponent(buttonTitle: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [IconButtonComponent(buttonTitle: "Få hjelp til frakt", iconImage: vanImage!)],
            [CollapsableDescriptionComponent(text: attributedDescriptionText, titleShow: "+ Vis hele beskrivelsen", titleHide: "- Vis mindre")],
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer"), MessageButtonComponent(title: "Ring", answerTime: "Tar aldri telefonen")],
            [PriceComponent(price: 1_500_000, locale: locale, accessibilityPrefix: "Pris: ")],
            [PriceComponent(price: 1200, locale: locale, accessibilityPrefix: "Pris: ", status: "Solgt")],
            [TableComponent(components: torgetTableElements)],
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

    lazy var objectView: SmashView = {
        let view = SmashView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setRightBarButtonItems([favoriteBarButtonItem, shareBarButtonItem], animated: false)

        view.addSubview(objectView)

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
        let alert = UIAlertController.dismissableAlert(title: "Favorite added!")
        present(alert, animated: true, completion: nil)
    }

    @objc func shareAd(sender: UIButton) {
        let alert = UIAlertController.dismissableAlert(title: "Share ad!")
        present(alert, animated: true, completion: nil)
    }
}

extension DemoViewController: SmashViewDataSource {
    func components(in objectView: SmashView) -> [[Component]] {
        return components
    }

    func customComponentView(for component: Component, in objectView: SmashView) -> UIView? {
        switch component.id {
        case "custom1": return CustomView()
        default: return nil
        }
    }
}

extension DemoViewController: SmashViewDelegate {
    func objectView(_ objectView: SmashView, didTapButtonFor component: IconButtonComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Button with id: \(component.id)")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, didTapExpandDescriptionFor component: CollapsableDescriptionComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Vis mer!")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, didTapHideDescriptionFor component: CollapsableDescriptionComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Vis mindre!")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, didTapSendMessageFor component: MessageButtonComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Send message!")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, didTapShowPhoneNumberFor component: PhoneNumberComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Show phone number for component: \(component.id)")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Calling: \(component.phoneNumber)")
        present(alert, animated: true, completion: nil)
    }

    func objectView(_ objectView: SmashView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return true
    }
}
