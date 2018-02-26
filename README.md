<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Paw/master/GitHub/cover-v4.png"></p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![](https://img.shields.io/badge/platform-iOS-lightgrey.svg) ![](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)

A simple and declarative library to display the details of an element. Even though we use it at FINN to display the details of our ads, we have create this library so it can be easily repurposed to display book details, recipe details, etc.

## Getting started

The entry point for the **Paw** library is the `PawView`. After adding a `PawView` to your `UIViewController` you'll just need to implement the `dataSource`. **Paw** uses **Components** to represent the strongly typed views that will be rendered, for a complete list of what's possible check the **Components** section bellow. After receiving the **Components**, the `PawView` will create **ComponentViews** for each **Component**. `PawView` communicates interaction using the `delegate` pattern. You can change your **Components** at any time and just call `reloadData`, `PawView` will make sure to reload its data in the smartest possible way so the user interaction isn't affected.

### Simple Demo

```swift
import Paw

class MyViewController: UIViewController {
    var components: [[Component]] {
        let locale = Locale(identifier: "nb_NO")
        return [
            [PriceComponent(price: 1_500_000, locale: locale, accessibilityPrefix: "Pris: ")],
            [CallToActionButtonComponent(title: "Send message", subtitle: "Usually replies within the hour")],
            [PhoneNumberComponent(phoneNumber: "12345678", descriptionText: "Mobile", showNumberText: "See phone number", accessibilityLabelPrefix: "Telefonnummer: ")],
            [LinkComponent(buttonTitle: "Hans Nordahls gate 64, 0841 Oslo", iconImage: pinImage!)],
            [DescriptionComponent(text: attributedDescriptionText, titleShow: "+ See more", titleHide: "- See less")],
            [LinkComponent(buttonTitle: "Need help with the delivery?", iconImage: vanImage!)],
            [TextListComponent(title: "Item code", detail: "123456789")],
            [SeparatorComponent()],
            [DateListComponent(title: "Last updated", date: Date())]
        ]
    }

    lazy var pawView: PawView = {
        let view = PawView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(pawView)
        NSLayoutConstraint.activate([pawView.topAnchor.constraint(equalTo: view.topAnchor), pawView.bottomAnchor.constraint(equalTo: view.bottomAnchor), pawView.leadingAnchor.constraint(equalTo: view.leadingAnchor), pawView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        pawView.dataSource = self
        pawView.reloadData()
    }
}

extension MyViewController: PawViewDataSource {
    func components(in pawView: PawView) -> [[Component]] { return components }

    func customComponentView(for component: Component, in pawView: PawView) -> UIView? { return nil }
}
```

### Result

<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Paw/master/GitHub/demo-v2.jpg"></p>

## Components

The current available **Components** are:

### Table
This **Component** consists in a collection of elements.

### Price
Needs description.

### Description
Needs description.

### Link
Needs description.

### PhoneNumber
Needs description.

### CallToActionButton
Needs description.

## Installation

### Carthage

```ruby
github "finn-no/Paw" "master"
```

### Supported iOS, OS X, watchOS and tvOS Versions

- iOS 9 and above

## License

**Paw** is available under the MIT license. See the [LICENSE](/LICENSE.md) file for more info.
