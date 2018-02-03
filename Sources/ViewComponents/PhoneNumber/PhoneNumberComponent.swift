import Foundation

public struct PhoneNumberComponent: Component {

    public let id: String

    public let phoneNumber: String
    let descriptionText: String
    let showNumberText: String
    let accessibilityLabelPrefix: String

    public init(id: String = UUID().uuidString, phoneNumber: String, descriptionText: String, showNumberText: String, accessibilityLabelPrefix: String) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.descriptionText = descriptionText
        self.showNumberText = showNumberText
        self.accessibilityLabelPrefix = accessibilityLabelPrefix
    }
}
