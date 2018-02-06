//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Astrup
import UIKit

class DemoViewController: UIViewController {
    let pinImage = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)
    let vanImage = UIImage(named: "SmallJobs")
    let imagePlaceholder = UIImage(named: "imagePlaceholder")!

    let attributedDescriptionText: NSAttributedString = {
        let descriptionText = "Selger min bestemors gamle sykkel. 🚲 Den er godt brukt, fungerer godt. Jeg har byttet slange, men latt være å gjøre noe mer på den. Du som kjøper den kan fikse den opp akkurat som du vil ha den :) Jeg ville aldri kjøpt den, men jeg satser på at du er dum nok til å bare gå for det. God jul og lykke til! 🌐 www.finn.no. 📌 Grensen 5, 0134 Oslo. 🗓 12.1.2018. ✈️ DY1234. 📞 12345678. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt."

        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.body,
            NSAttributedStringKey.foregroundColor: UIColor.stone,
        ]

        let attributedString = NSAttributedString(string: descriptionText, attributes: attributes)
        return attributedString
    }()

    var components: [[Component]] {
        let locale = Locale(identifier: "nb_NO")
        return [
            [TitleComponent(text: "Lekker 1 roms i originale Waldemars Hage, inkl varmtvann/fyring, internett og tv")],
            [GalleryComponent(placeholder: imagePlaceholder, stringURLs: ["https://images.finncdn.no/dynamic/480x360c/2017/9/vertical-5/30/5/105/424/_1263219766.jpg", "https://images.finncdn.no/dynamic/480x360c/2017/7/vertical-2/19/3/100/464/_1229205040.jpg"])],
            [CustomComponent(id: "custom1")],
            [CallToActionButtonComponent(title: "Send melding", subtitle: "Svarer vanligvis innen 4 timer")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobil", showNumberText: "Vis telefonnummer", accessibilityLabelPrefix: "Telefonnummer: ")],
            [LinkComponent(title: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [LinkComponent(title: "Få hjelp til frakt")],
            [DescriptionComponent(text: attributedDescriptionText, titleShow: "+ Vis hele beskrivelsen", titleHide: "- Vis mindre", isCollapsable: true)],
            [CallToActionButtonComponent(title: "Send melding", subtitle: "Svarer vanligvis innen 4 timer"), CallToActionButtonComponent(title: "Ring")],
            [PriceComponent(price: 1_500_000, locale: locale, accessibilityPrefix: "Pris: ")],
            [PriceComponent(price: 1200, locale: locale, accessibilityPrefix: "Pris: ", status: "Solgt")],
            [TextListComponent(title: "FINN-kode", detail: "123456789")],
            [SeparatorComponent()],
            [DateListComponent(title: "Sist endret", date: Date())],
            [SeparatorComponent()],
            [PhoneNumberListComponent(title: "Mobil", phoneNumber: "12345678")],
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

    lazy var astrupView: AstrupView = {
        let view = AstrupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setRightBarButtonItems([favoriteBarButtonItem, shareBarButtonItem], animated: false)

        view.addSubview(astrupView)

        NSLayoutConstraint.activate([
            astrupView.topAnchor.constraint(equalTo: view.topAnchor),
            astrupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            astrupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            astrupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        astrupView.dataSource = self

        astrupView.galleryDelegate = self
        astrupView.phoneNumberDelegate = self
        astrupView.callToActionButtonDelegate = self
        astrupView.linkDelegate = self
        astrupView.phoneNumberListDelegate = self

        astrupView.reloadData()
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

extension DemoViewController: AstrupViewDataSource {
    func components(in astrupView: AstrupView) -> [[Component]] {
        return components
    }

    func customComponentView(for component: Component, in astrupView: AstrupView) -> UIView? {
        switch component.id {
        case "custom1": return CustomView()
        default: return nil
        }
    }
}

extension DemoViewController: GalleryAstrupViewDelegate {
    func astrupView(_ astrupView: AstrupView, stringURL: String, imageCallBack: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: stringURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                imageCallBack(nil)
            } else {
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        imageCallBack(image)
                    } else {
                        imageCallBack(nil)
                    }
                }
            }
        }.resume()
    }
}

extension DemoViewController: PhoneNumberAstrupViewDelegate {
    func astrupView(_ astrupView: AstrupView, didTapPhoneNumberFor component: PhoneNumberComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Calling: \(component.phoneNumber)")
        present(alert, animated: true, completion: nil)
    }

    func astrupView(_ astrupView: AstrupView, canShowPhoneNumberFor component: PhoneNumberComponent) -> Bool {
        return true
    }
}

extension DemoViewController: CallToActionButtonAstrupViewDelegate {
    func astrupView(_ astrupView: AstrupView, didTapSendMessageFor component: CallToActionButtonComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Send message!")
        present(alert, animated: true, completion: nil)
    }
}

extension DemoViewController: LinkAstrupViewDelegate {
    func astrupView(_ astrupView: AstrupView, didTapButtonFor component: LinkComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Button with id: \(component.id)")
        present(alert, animated: true, completion: nil)
    }
}

extension DemoViewController: PhoneNumberListAstrupViewDelegate {
    func astrupView(_ astrupView: AstrupView, didTapPhoneNumberFor component: PhoneNumberListComponent) {
        let alert = UIAlertController.dismissableAlert(title: "Calling: \(component.phoneNumber)")
        present(alert, animated: true, completion: nil)
    }
}
