import Foundation

struct TextTableComponent: TableElement {

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
