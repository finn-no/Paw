import Foundation

struct TextTableComponent: TableRowModel {

    let title: String
    let detail: String

    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }

    var accessibilityLabel: String? {
        return title + ": " + detail
    }
}
