import Foundation

struct PhoneNumberComponent: Component {
    let id: String
    let type: ComponentType = .phoneNumber

    let phoneNumber: String
    let descriptionText: String
    let showNumberText: String
    let accessibilityLabelPrefix: String

    init(id: String = UUID().uuidString, phoneNumber: String, descriptionText: String, showNumberText: String, accessibilityLabelPrefix: String) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.descriptionText = descriptionText
        self.showNumberText = showNumberText
        self.accessibilityLabelPrefix = accessibilityLabelPrefix
    }
}
