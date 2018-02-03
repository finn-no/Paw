<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Smash/master/GitHub/cover-v2.png"></p>

A simple and declarative library to display the details of an element. In FINN we use it to display the detail of our ads, but it can be easily repurposed to display book details, recipe details, etc.

## Basic usage

```swift
import Smash

class MyViewController: UIViewController {
    let elements: [TableElement] = {
        let locale = Locale(identifier: "nb_NO")
        let timeInterval = TimeInterval(exactly: 450_033_400)!
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        return [
            TextTableElement(title: "Item code", detail: "123456789"),
            DateTableElement(title: "Last updated", date: date),
        ]
    }()

    var components: [[Component]] {
        let locale = Locale(identifier: "nb_NO")
        return [
            [PriceComponent(price: 1_500_000, locale: locale, accessibilityPrefix: "Pris: ")],
            [MessageButtonComponent(title: "Send message", answerTime: "Usually replies within the hour")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobile", showNumberText: "See phone number", accessibilityLabelPrefix: "Telefonnummer: ")],
            [IconButtonComponent(buttonTitle: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [CollapsableDescriptionComponent(text: attributedDescriptionText, titleShow: "+ See more", titleHide: "- See less")],
            [IconButtonComponent(buttonTitle: "Need help with the delivery?", iconImage: vanImage!)],
            [TableComponent(components: elements)],
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
        NSLayoutConstraint.activate([smashView.topAnchor.constraint(equalTo: view.topAnchor), smashView.bottomAnchor.constraint(equalTo: view.bottomAnchor), smashView.leadingAnchor.constraint(equalTo: view.leadingAnchor), smashView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        smashView.dataSource = self
        smashView.reloadData()
    }
}

//... SmashViewDataSource

extension MyViewController: SmashViewDataSource {
    func components(in smashView: SmashView) -> [[Component]] {
        return components
    }
}
```

<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Smash/master/GitHub/demo.png"></p>

## Installation

### Carthage

```ruby
github "finn-no/Smash" "master"
```

### Supported iOS, OS X, watchOS and tvOS Versions

- iOS 9 and above

## License

**Smash** is available under the MIT license. See the [LICENSE](/LICENSE.md) file for more info.
