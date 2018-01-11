import Foundation

enum ComponentType {
    case link
    case title
    case custom
    case gallery
    case profile
    case price
    case messageButton
    case phoneNumber
    case adress
    case description
    case category
    case banner
    case safePay
    case loanPrice
    case deliveryHelp
    case adReporter
    case adInfo
    case relevantAds
}

protocol Component {
    var id: String { get }
    var type: ComponentType { get }
    var actions: [ComponentAction] { get }
}

enum ComponentAction {
    case show
    case call
}
