import Foundation

class Component {

    enum ComponentType {
        case link
        case title
    }

    var id: String
    var type: ComponentType

    init(id: String, type: ComponentType) {
        self.id = id
        self.type = type
    }
}
