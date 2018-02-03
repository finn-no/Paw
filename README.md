<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Smash/master/GitHub/cover.png"></p>

A simple and declarative library to display the details of an element. In FINN we use it to display the detail of our ads, but it can be easily repurposed to display book details, recipe details, etc.

## Basic usage

```swift
import Smash

class DemoViewController: UIViewController {
    var components: [[Component]] {
        let locale = Locale(identifier: "nb_NO")
        return [
            [PriceComponent(price: 1200, locale: locale, accessibilityPrefix: "Pris: ", status: "Solgt")],        
            [MessageButtonComponent(title: "Send melding", answerTime: "Svarer vanligvis innen 4 timer")],
            [CollapsableDescriptionComponent(text: attributedDescriptionText, titleShow: "+ Vis hele beskrivelsen", titleHide: "- Vis mindre")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobil", showNumberText: "Vis telefonnummer", accessibilityLabelPrefix: "Telefonnummer: ")],
            [IconButtonComponent(buttonTitle: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [IconButtonComponent(buttonTitle: "Få hjelp til frakt", iconImage: vanImage!)],
            [TableComponent(components: torgetTableElements)],
        ]
    }

    lazy var smashView: SmashView = {
        let view = SmashView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(smashView)

        NSLayoutConstraint.activate([
            smashView.topAnchor.constraint(equalTo: view.topAnchor),
            smashView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            smashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            smashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        smashView.dataSource = self
        smashView.reloadData()
    }
}

//... SmashViewDataSource

extension MyViewController: SmashViewDataSource {
    func components(in smashView: SmashView) -> [[Component]] {
        return components
    }

    func customComponentView(for component: Component, in smashView: SmashView) -> UIView? {
        return nil
    }
}
```

## Installation

### Carthage

```ruby
github "finn-no/Smash" "master"
```

### Supported iOS, OS X, watchOS and tvOS Versions

- iOS 9 and above

## License

**Smash** is available under the MIT license. See the [LICENSE](/LICENSE.md) file for more info.
