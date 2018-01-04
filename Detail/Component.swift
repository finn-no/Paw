import Foundation

class Component {

    enum ComponentType {
        case link
        case title
        case custom
        case gallery
        case profile
        case price
        case messageButton
        case showNumberButton
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

    var id: String
    var type: ComponentType

    init(id: String, type: ComponentType) {
        self.id = id
        self.type = type
    }
}
