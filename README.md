<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Astrup/master/GitHub/cover-v3.png"></p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![](https://img.shields.io/badge/platform-iOS-lightgrey.svg) ![](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)

A simple and declarative library to display the details of an element. Even though we use it at FINN to display the details of our ads, we have create this library so it can be easily repurposed to display book details, recipe details, etc.

## Getting started

The entry point for the **Astrup** library is the `AstrupView`. After adding a `AstrupView` to your `UIViewController` you'll just need to implement the `dataSource`. **Astrup** uses **Components** to represent the strongly typed views that will be rendered, for a complete list of what's possible check the **Components** section bellow. After receiving the **Components**, the `AstrupView` will create **ComponentViews** for each **Component**. `AstrupView` communicates interaction using the `delegate` pattern. You can change your **Components** at any time and just call `reloadData`, `AstrupView` will make sure to reload its data in the smartest possible way so the user interaction isn't affected.

### Simple Demo

```swift
import Astrup

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

    lazy var astrupView: AstrupView = {
        let view = AstrupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(astrupView)
        NSLayoutConstraint.activate([astrupView.topAnchor.constraint(equalTo: view.topAnchor), astrupView.bottomAnchor.constraint(equalTo: view.bottomAnchor), astrupView.leadingAnchor.constraint(equalTo: view.leadingAnchor), astrupView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        astrupView.dataSource = self
        astrupView.reloadData()
    }
}

extension MyViewController: AstrupViewDataSource {
    func components(in astrupView: AstrupView) -> [[Component]] { return components }

    func customComponentView(for component: Component, in astrupView: AstrupView) -> UIView? { return nil }
}
```

### Result

<p align="center"><img width=100% src="https://raw.githubusercontent.com/finn-no/Astrup/master/GitHub/demo.png"></p>

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
github "finn-no/Astrup" "master"
```

### Supported iOS, OS X, watchOS and tvOS Versions

- iOS 9 and above

## License

**Astrup** is available under the MIT license. See the [LICENSE](/LICENSE.md) file for more info.
