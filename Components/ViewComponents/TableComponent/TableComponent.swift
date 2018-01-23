import Foundation

struct TableComponent: Component {

    let id: String
    let components: [TableRowModel]

    init(id: String = UUID().uuidString, components: [TableRowModel]) {
        self.id = id
        self.components = components
    }
}
