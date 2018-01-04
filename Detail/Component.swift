import Foundation

class Component {

    enum ComponentType {
        case link
        case title
        case custom
    }

    var id: String
    var type: ComponentType

    init(id: String, type: ComponentType) {
        self.id = id
        self.type = type
    }
}
