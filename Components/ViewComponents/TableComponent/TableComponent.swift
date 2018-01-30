import Foundation

struct TableComponent: Component {

    let id: String
    let components: [TableElement]

    init(id: String = UUID().uuidString, components: [TableElement]) {
        self.id = id
        self.components = components
    }
}
