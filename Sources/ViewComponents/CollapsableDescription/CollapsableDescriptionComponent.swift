import Foundation

public struct CollapsableDescriptionComponent: Component {

    public let id: String

    let text: NSAttributedString
    let titleShow: String
    let titleHide: String

    public init(id: String = UUID().uuidString, text: NSAttributedString, titleShow: String, titleHide: String) {
        self.id = id
        self.text = text
        self.titleShow = titleShow
        self.titleHide = titleHide
    }
}
