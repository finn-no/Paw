struct PhoneNumberComponent: Component {
    let id: String
    let type: ComponentType = .phoneNumber

    let phoneNumber: String
    let descriptionText: String
    let showNumberText: String
    let accessibilityLabelPrefix: String
}
