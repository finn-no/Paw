import UIKit

public struct IconButtonComponent: Component {

    public let id: String

    let buttonTitle: String
    let iconImage: UIImage

    public init(id: String = UUID().uuidString, buttonTitle: String, iconImage: UIImage) {
        self.id = id
        self.buttonTitle = buttonTitle
        self.iconImage = iconImage
    }
}
