import Foundation

struct TableComponent: Component {

    let id: String
    let components: [TableComponent]

    init(id: String = UUID().uuidString, components: [TableComponent]) {
        self.id = id
        self.components = components
    }
}
