import UIKit

struct IconButtonComponent: Component {

    let id: String

    let buttonTitle: String
    let iconImage: UIImage

    init(id: String = UUID().uuidString, buttonTitle: String, iconImage: UIImage) {
        self.id = id
        self.buttonTitle = buttonTitle
        self.iconImage = iconImage
    }
}
