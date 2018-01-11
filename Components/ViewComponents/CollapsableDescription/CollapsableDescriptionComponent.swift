import Foundation

struct CollapsableDescriptionComponent: Component {

    let id: String

    let text: String
    let titleShow: String
    let titleHide: String
    let accessibilityLabelPrefix: String

    init(id: String = UUID().uuidString, text: String, titleShow: String, titleHide: String, accessibilityLabelPrefix: String) {
        self.id = id
        self.text = text
        self.titleShow = titleShow
        self.titleHide = titleHide
        self.accessibilityLabelPrefix = accessibilityLabelPrefix
    }
}
