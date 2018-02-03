import Foundation

public struct CallToActionButtonComponent: Component {
    public let id: String
    let title: String
    let subtitle: String?

    public init(id: String = UUID().uuidString, title: String, subtitle: String? = nil) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}
